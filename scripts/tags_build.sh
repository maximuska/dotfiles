echo Running...
find -name "*.c" -or -name "*.cc" -or -name "*.h" -or -name "*.xml" -or -name "*.py" | grep -v .xmake.build > .files
echo Total files: `wc -l .files`
cat .files | pv -l | etags -L -
cat .files | pv -l | ctags -L -
gtags -f .files
#cat .files | pv -l | cscope -b -i -
