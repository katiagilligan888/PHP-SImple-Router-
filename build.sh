
#!/usr/bin/env bash
#-- Shared variables ----------
project_owner="katiagilligan"
project_name="php-simple-router"

process="build"
#-- Begin ----------
echo "Preparing ${process} shell for ${project_owner}/${project_name}"

#-- Create image with build tools ----------
image_tag="${project_owner}/${project_name}:build"
working_directory="/${process}/${project_owner}/${project_name}"
sudo docker build                                                          \
  --network host                                                            \
  --tag ${image_tag}                                                        \
  --file Dockerfile                                                         \
  ./

#-- Create container for build / extract ----------
container_name="${project_owner}_${project_name}_ephemeral_${process}_context"
build_directory="/var/www/html"
sudo docker run                                                            \
  -p 80:8080                                                               \
  --name ${container_name}                                                 \
  --interactive                                                            \
  --tty                                                                    \
  --rm                                                                     \
  ${image_tag}                                                              \

