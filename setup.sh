DOTFILES=( .vimrc .zshrc .emacs.d )

for file in ${DOTFILES[@]}
do
  if [ -a $HOME/$file ]; then
    echo "File exists: $file"
  else
    ln -s $HOME/repos/syucream/dotfiles/$file $HOME/$file
    echo "Symlink created: $file"
  fi
done

if [ -a $HOME/.nvimrc ]; then
  echo "File exists: .nvimrc"
else
  ln -s $HOME/.vimrc $HOME/.nvimrc
fi
