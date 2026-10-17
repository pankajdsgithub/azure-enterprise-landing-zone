# Enterprise Operational Runbooks & Troubleshooting Guide

This guide provides standard operating procedures (SOPs) for resolving common platform incidents, managing state locks, and recovering partially provisioned resources.

---

## 1. Handling Stuck Terraform State Locks

### Symptom
A pipeline fails with an error stating that the state file is locked by another operation (`Error acquiring the state lock`).

### Resolution
1. Verify that no other pipeline or engineer is actively running an apply against that specific state boundary.
2. Retrieve the lock ID from the error message or Azure Storage Account lease.
3. Force-unlock the state manually (use with extreme caution):
   ```bash
   terraform force-unlock <LOCK_ID>
   