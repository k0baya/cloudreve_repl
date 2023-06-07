repo="cloudreve/Cloudreve"

releases=$(curl -s "https://api.github.com/repos/$repo/releases")

pre_release_tag=$(echo "$releases" | jq -r '.[] | select(.prerelease == true) | .tag_name' | head -n 1)

if [[ -n $pre_release_tag ]]; then
    tag=$pre_release_tag
else
    tag=$(echo "$releases" | jq -r '.[0].tag_name')
fi

echo "$repo/$tag"

download_url="https://github.com/$repo/releases/download/$tag/cloudreve_${tag}_linux_amd64.tar.gz"

echo "downloading $download_url"

wget "$download_url" -O cloudreve.tar.gz

tar -zxvf "cloudreve.tar.gz" --overwrite

rm "cloudreve.tar.gz" "LICENSE" "README.md" "README_zh-CN.md"

chmod +x cloudreve

./cloudreve
