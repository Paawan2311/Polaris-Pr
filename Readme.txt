# Polaris DevOps Project #

This project showcases end-to-end DevOps automation on AWS with infrastructure provisioning, CI/CD, Helm deployments, and API routing.

---

## 1. Infrastructure (Terraform)

We establish a private EKS cluster within a new VPC with 3 public + 3 private subnets. Terraform employs custom modules to enable code reusability.

Steps:

1. Initialize Terraform.
2. Approve the plan.
3. Apply to provision VPC + EKS cluster.

---

## 2. Kubernetes Setup

After the cluster is available, set up `kubectl` to connect to it from a bastion host or EC2 with SSM.

* Install EBS CSI Driver to enable persistent storage for Jenkins and other applications.
* Install Kong API Gateway (internal) to route all API traffic inside the VPC.
* Install Jenkins on EKS using Helm with persistent storage, and expose it internally via Kong.

---

## 3. Application Helm Chart

We have a generic Helm chart for a multi-tier app:

* Frontend (web)
* Backend (API)

The chart enables you to modify image repository, tags, ports, and ingress host through `values.yaml`.

---

## 4. Jenkins Pipeline

The pipeline (Jenkinsfile) performs the following:

1. Checks out the code from the repository.
2. Builds Docker images for frontend and backend.
3. Pushes images to ECR.
4. Installs the application using the Helm chart to EKS.
5. Can auto-trigger on repository changes through GitHub webhook or polling.

---

## 5. API Routing

* All Jenkins UI and APIs are exposed through Kong Ingress.
* Example internal URLs:

  * Jenkins UI → `jenkins.internal`
  * Backend API → `api.internal`

You can reach them from a bastion host within the VPC.

---

## 6. Workflow Summary

1. Deploy infrastructure with Terraform.
2. Connect to EKS cluster.
3. Install EBS CSI, Kong, and Jenkins through Helm.
4. Push app code (frontend + backend) to repo.
5. Jenkins builds Docker images and pushes to ECR.
6. Jenkins deploys Helm chart → application is live.
7. Access APIs via Kong.

---

## 7. Security & Production Notes

* Use IRSA for Jenkins & EBS CSI instead of long-lived AWS keys.
* Store secrets in AWS Secrets Manager or Kubernetes External Secrets.
* Harden Kong Admin API (TLS, RBAC, authentication).
* Enable autoscaling (HPA) for backend.
* Use ACM + ALB if exposing APIs to the public.

---

## 8. Troubleshooting Tips

* Check Jenkins pods: `kubectl -n jenkins get pods`
* Check Kong logs: `kubectl -n kong logs -l app.kubernetes.io/name=kong -c proxy`
* Check PVCs: `kubectl get pvc -A`
