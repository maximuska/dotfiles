echo Running...
find -name "*.c" -or -name "*.cc" -or -name "*.C" -or -name "*.h" -or -name "*.xh" -or -name "*.xml" -or -name "*.py" | grep -v .xmake.build | grep -v "_test.c" > .files
echo Total files: `wc -l .files`
gtags -I -f .files&
etags -L .files&
ctags -L .files&
#cat .files | pv -l | cscope -b -i -
echo Waiting for tags to be prepared..
wait
