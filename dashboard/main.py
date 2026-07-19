from fastapi import FastAPI
from fastapi.responses import HTMLResponse
from sse_starlette.sse import EventSourceResponse
from kubernetes import client, config
import asyncio

app = FastAPI()

# Load kube config (assumes running locally where kubeconfig exists)
try:
    config.load_kube_config()
except:
    pass

v1 = client.CoreV1Api()

@app.get("/")
def get_dashboard():
    with open("index.html", "r") as f:
        return HTMLResponse(f.read())

async def status_generator():
    while True:
        pods = []
        try:
            ret = v1.list_namespaced_pod(namespace="default", label_selector="app=api")
            for i in ret.items:
                pods.append({"name": i.metadata.name, "status": i.status.phase})
        except Exception as e:
            pass

        data = {
            "containers": pods
        }
        import json
        yield {"data": json.dumps(data)}
        await asyncio.sleep(1)

@app.get("/stream")
async def stream():
    return EventSourceResponse(status_generator())
