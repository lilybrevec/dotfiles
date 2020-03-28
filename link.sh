ln -s ~/dotfiles/config/.emacs.d/elisp ~/.emacs.d
ln -s ~/dotfiles/config/.emacs.d/init.el ~/.emacs.d

zsh
ln -s .zplugin/plugins/sorin-ionescu---prezto/ .zprezto
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
