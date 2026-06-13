#!/bin/bash
section_name=docs/source/"$1"

mkdir $section_name
cd $section_name

cat <<EOF > index.md
# $1
```{{toctree}}
00
10
20
30
40
50
```
EOF

for i in {0..5}
do
  echo "# ${i}0" > "${i}0.md"
done