# Image Sync Action

This action syncs container images between different registries using [image-syncer](https://github.com/AliyunContainerService/image-syncer).

## Inputs

* `source_registry`: Source registry address
* `source_username`: Source registry username (optional)
* `source_password`: Source registry password (optional)
* `dest_registry`: Destination registry address
* `dest_username`: Destination registry username
* `dest_password`: Destination registry password
* `image_list_file`: Path to the image list YAML file
* `concurrent`: Number of concurrent sync processes (default: 6)
* `retries`: Number of retries for failed sync (default: 3)
* `image_syncer_version`: Version of image-syncer to use (default: v1.3.1)

## Image List File Format

Create a YAML file (e.g., `.github/image-list.yaml`) with the following format:

```yaml
# source_image: destination_image
registry.cn-hangzhou.aliyuncs.com/namespace/image1:tag: ghcr.io/username/image1:tag
registry.cn-hangzhou.aliyuncs.com/namespace/image2:tag: ghcr.io/username/image2:tag

