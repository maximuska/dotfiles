echo Running...
find . -name "*.c" -or -name "*.h" | grep -v .xmake.build > .files
echo Total files: `wc -l .files`
cat .files | pv -l | etags -L -
cat .files | pv -l | ctags -L -
gtags -f .files
#cat .files | pv -l | cscope -b -i -
