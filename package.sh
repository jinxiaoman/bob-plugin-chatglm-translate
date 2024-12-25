version=$(jq -r .version ./src/info.json)

zip -0 -j  -r ./bob-plugin-chatglm-translate-v$version.bobplugin ./src/*


version=$(jq -r .version ./src/info.json)

echo $version

hash=$(shasum -a 256 ./bob-plugin-chatglm-translate-v$version.bobplugin | cut -d ' ' -f 1)

timestamp=$(date +%s000)

newVersion=$(cat << EOF
{
  "version": "v$version",
  "desc": "新增功能",
  "sha256": "$hash",
  "url": "https://github.com/lxlhlp/bob-plugin-chatglm-translate/releases/download/v$version/bob-plugin-chatglm-translate-v$version.bobplugin",
  "minBobVersion": "0.0.1",
 "timestamp": $timestamp
}
EOF
)

echo $newVersion

jq --argjson newVersion "$newVersion" '.versions |= [$newVersion] + .' ./appcast.json > temp.json


mv temp.json ./appcast.json
