# fargate-bastion

## Prepare

1. Make IAM role for ECSTask
1. Add policy written in policy.json to IAM role
1. Create ssh keys (ssh-keygen)
    - `id_rsa` and `id_rsa.pub` will be created
1. Build docker image
    - `docker image build --platform=amd64 -t fargate-bastion .`

## Note

This image has no db clients. If you want to connect to database in private subnet from this container, you have to add some db client.

