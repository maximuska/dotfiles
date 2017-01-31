#!/bin/bash -e

echo Running...
find -not \( -path \*/.xmake.build* -prune \) -not \( -path ./kernel/tree\* -prune \) -not \( -path ./new_outputs -prune \) \
  -name "*.c" -or -name "*.cc" -or -name "*.C" -or -name "*.h" -or -name "*.xh" -or -name "*.xml" -or -name "*.py" -or -name "*.pyx" > .files
echo Total files: `wc -l .files`
#exit 1
#gtags -I -f .files&
gtags -f .files&
#etags -L .files&
ctags -L .files --c++-kinds=+p --fields=+iaS --extra=+q --extra=+f --langmap=c:+.xh -h+.xh -IUNINSTRUMENTED&
#cscope -b -q -v -i.files&
#cat .files | pv -l | cscope -b -i -
echo Waiting for tags to be prepared..
wait
rm -f .files
