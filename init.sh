#! /bin/bash

git submodule init
git submodule update

files=.*

for file in ${files}
do
  filepath="${PWD}/${file}"
  homefile="${HOME}/${file}"
  
  test $file == ".git" && continue
  test $file == ".gitignore" && continue
  test $file == ".gitmodules" && continue
  test $file == "." && continue
  test $file == ".." && continue

  if [ ! -e "${homefile}" ]; then
    echo "${file} not exists, make symbolic link to ${homefile}."
    ln -s "${filepath}" "${homefile}"
  else
    echo "${file} exists."
  fi
done
