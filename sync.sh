#!/bin/bash
set -e

echo "Starting image sync process..."

# 下载并安装 image-syncer
echo "Installing image-syncer ${INPUT_IMAGE_SYNCER_VERSION}..."
wget "https://github.com/AliyunContainerService/image-syncer/releases/download/${INPUT_IMAGE_SYNCER_VERSION}/image-syncer-${INPUT_IMAGE_SYNCER_VERSION}-linux-amd64.tar.gz"
tar -zxf "image-syncer-${INPUT_IMAGE_SYNCER_VERSION}-linux-amd64.tar.gz"
chmod +x image-syncer
sudo mv image-syncer /usr/local/bin/

# 创建认证配置文件
echo "Creating auth configuration..."
cat > auth.yaml << EOF
${INPUT_SOURCE_REGISTRY}:
  username: ${INPUT_SOURCE_USERNAME}
  password: ${INPUT_SOURCE_PASSWORD}
${INPUT_DEST_REGISTRY}:
  username: ${INPUT_DEST_USERNAME}
  password: ${INPUT_DEST_PASSWORD}
EOF

# 检查镜像列表文件是否存在
if [ ! -f "${INPUT_IMAGE_LIST_FILE}" ]; then
    echo "Error: Image list file '${INPUT_IMAGE_LIST_FILE}' not found!"
    exit 1
fi

# 执行同步
echo "Starting image sync with concurrent=${INPUT_CONCURRENT} and retries=${INPUT_RETRIES}..."
image-syncer --proc=${INPUT_CONCURRENT} --auth=auth.yaml --images=${INPUT_IMAGE_LIST_FILE} --retries=${INPUT_RETRIES} --os=linux --arch=${IMAGE_ARCH}

echo "Image sync completed successfully!"

