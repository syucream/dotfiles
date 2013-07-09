# powerline シンボルの導入を行います

mkdir etc/
git clone git://github.com/Lokaltog/powerline.git etc/powerline/
mkdir ~/.fonts/
cp etc/powerline/font/PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts
mkdir ~/.fonts.conf.d/
cp etc/powerline/font/10-powerline-symbols.conf ~/.fonts.conf.d/

# tmux-powerline の導入を行います
# フォント修正不要の設定を行います。TODO: さすがにもっと賢い設定導入方法を考えたい
git clone git://github.com/erikw/tmux-powerline.git etc/tmux-powerline/
cp conf/tmux-powerline/my.sh etc/tmux-powerline/themes/
sed -i 's/branch_symbol\=\".\"/branch_symbol\=\"br:\"/' etc/tmux-powerline/segments/vcs_branch.sh
ln -s ~/repos/dotfiles/conf/tmux-powerline/.tmux-powerlinerc ~/.tmux-powerlinerc

