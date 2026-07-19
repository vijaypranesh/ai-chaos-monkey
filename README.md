# ⚔️ Autonomous SRE Arena (AI Thunderdome)

> **I am officially done waking up at 3 AM to fix Kubernetes. So I built an AI that does it for me.**

Welcome to the **Autonomous SRE Arena**, a local sandbox environment designed to demonstrate **Adversarial Agentic DevOps**. This project pits two AI agents against each other inside a live Kubernetes cluster:

- 🔴 **The Chaos Monkey:** Programmed to simulate massive node failures and aggressively scale down critical deployments.
- 🔵 **The Auto-SRE:** Programmed to monitor the cluster, diagnose failures, and apply self-healing fixes in real-time.

## 🚀 Quick Start

### Prerequisites
- [Docker](https://docs.docker.com/get-docker/) installed.
- [Kind](https://kind.sigs.k8s.io/) (Kubernetes in Docker) installed.
- [Python 3.9+](https://www.python.org/) installed.
- [Antigravity IDE](https://antigravity.dev/) (or any multi-agent orchestrator).

### 1. Spin up the Arena
Run the automated startup script to create the local Kubernetes cluster, deploy the API, and start the live visualization dashboard:

```bash
chmod +x start.sh
./start.sh
```

### 2. View the Live Dashboard
Open your browser to `http://localhost:3006`. You will see the Live Kubernetes Dashboard displaying the state of the API replicas.

### 3. Unleash the AI Swarm
Open Antigravity and paste the following Master Prompt to spawn the Adversarial AI agents:

<details>
<summary>Click to view the Master Prompt</summary>

```text
/goal You are the Lead Platform Engineer. We have a local Kubernetes cluster running.

Step 1: Use `define_subagent` to create "The Chaos Monkey". 
System Prompt: "You are an advanced QA Engineer simulating a massive node failure. Run `kubectl scale deployment api-deployment --replicas=1`. Wait 25 seconds for the SRE to recover it, then do it a second time. After 2 rounds, report back."
Enable terminal tools for this agent.

Step 2: Use `define_subagent` to create "The Auto-SRE". 
System Prompt: "You are an Advanced SRE. Your job is to monitor the cluster. When you detect that the `api-deployment` has been scaled down to 1, you must WAIT 15 seconds (simulating human diagnosis time), and then actively recover the cluster by running `kubectl scale deployment api-deployment --replicas=3`. You must do this for 2 rounds. Report back when you are finished."
Enable terminal tools for this agent.

Step 3: Use `invoke_subagent` to launch both agents in parallel. Let them run their resilience drill.
```
</details>

## 🏗 Architecture
- **Infrastructure:** Local `kind` Kubernetes cluster.
- **Application:** Nginx deployment configured for High Availability (3 Replicas).
- **Dashboard:** A FastAPI Python client that polls the Kubernetes API and streams pod states to the browser via SSE (Server-Sent Events).
- **Agents:** Two LLM-powered subagents executing structured `kubectl` commands.

## 🤝 Contributing
Want to build more advanced Chaos Monkeys? PRs are welcome!
