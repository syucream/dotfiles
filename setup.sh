DOT_FILES=( .vimrc .zshrc .emacs.d )

for file in ${DOT_FILES[@]}
do
  if [ -a $HOME/$file ]; then
    echo "File exists: $file"
  else
    ln -s $HOME/repos/dotfiles/$file $HOME/$file
    echo "Symlink created: $file"
  fi
done

if [ -a $HOME/.nvimrc ]; then
  echo "File exists: .nvimrc"
else
  ln -s $HOME/.vimrc $HOME/.nvimrc
fi
