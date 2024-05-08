cd ..
cd infra
cd functions
terraform destroy --auto-approve

cd ..
cd registry
terraform destroy --auto-approve

echo "all destroyed"