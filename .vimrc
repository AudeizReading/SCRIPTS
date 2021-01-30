" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Rouvrir un fichier à la ligne `n`
" vim +n file
" Mettre une marque dans un fichier
" En mode normal, sous le mot : ma (a ou une autre lettre si a déjà pris)
" Se postionner sur la marque (mode normal)
" 'a

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Options activées personnellement
" Affichage des numéros de ligne
set nu
" Affichage des numéros de ligne relatifs à la position courante
set relativenumber
" Met en évidence la position du curseur par une ligne horizontale
set cursorline
" Affichage commande en cours
set showcmd
" Affichage du mode VIM
set showmode
" Utilisation du clignotement visuel au lieu du bip
set visualbell
" Affichage crochets/parenthèses/accolades correspondant
set showmatch
" Affiche une nouvelle fenêtre en dessous de l'ancienne (par exemple qd on apl l'aide)
set splitbelow
set mouse=a		" Enable mouse usage (all modes)

" Configuration de la barre de statut (set ruler n'a plus lieu d'être)
set laststatus=2 " Affiche toujours la barre d'état, 0=jamais, 1=seulement qd 2 écrans, 2=toujours
set statusline=%<%F\ %h%m%r\ %y\ %a%=%-20.(%l,%c%V%)\ %p\ %%\  " Affiche filepath, si aide/modif ou readonly, type de fichier, arguments du fichier, = sépare l'alignement dans la barre, - aligne à gauche sauf si la taille mini est inf à celle indiquée alors aligne à droite, donne nb lignes, nb colonnes+virtuelles, % dans le fichier
highlight StatusLine term=reverse,bold cterm=reverse,bold ctermfg=15 ctermbg=0 gui=reverse,bold

" Taille max d'une ligne 
set textwidth=80
" Coupe les lignes au dernier mots et pas au caractères (requière Wrap Lines actif par défaut)
set wrap " Autorise coupure des lignes en affichage
set linebreak

" Autoindentation des lignes
set autoindent
set smartindent " si smartindent activé, alors activer autoindent, si cindent activé = smartindent sans effet
set copyindent " copie l'indentation précédente en autoindentation
"set expandtab " expand tabs by default (overloadable per file type) remplace les tabulations par des espaces 
set shiftround " utilise des multiples de shiftwidth quand indentation avec < ou >
set smarttab "insert tabs on the start of a line according to shiftwidth, not tabstop 
" Définition taille auto-indentation
set shiftwidth=4 " nombre d'espaces à utiliser pour chaque pas d'auto-indentation, valeur utilisée par smarttab
" Taille d'une tabulation
set tabstop=4
set softtabstop=4 " when hitting <BS>, pretend like a tab is removed even if spaces

" auto-format fichier .c : utilise le cindent, formatoptions permet d'utiliser
" le textwidth (sinon j'ai des soucis avec en C, ne se coupe pas à la col 80) et
" formatte les commentaires C de la façon suivante 
" /* 
" ** Ceci est un commentaire C
" */
" Pour la dernière ligne de commentaire, comme il ne sait pas encore que c'est
" la dernière ligne, elle commencera par **, le simple fait de taper / annule **
" le commentaire se terminera alors
"autocmd FileType c set cindent formatoptions=tcroq comments=sl:/*,mb:**,elx:*
autocmd FileType c set cindent formatoptions=tcroq comments=sl:/*,mb:**,elx:*/

" Il est aussi possible de modifier la date et l'heure de modification dans un
" fichier donné , exemple avec un fichier .html :
" (www.davide.blanchet.free.fr/vim/doc/fr62017/autocmd.txt.html, *skeleton*)
" :autocmd BufWritePre, FileWritePre *.html     ks|call DerModif()|'s
" :fun DerModif()
" :		if line("$") > 20
" :			let l = 20
" :		else
" :			let l = line("$")
" :		endif
" :		exe "1," . l . "g/Dernière modification : /s/Dernière modification :
" .*/Dernière modification : " . \ strftime("%d %b %Y %X %Z")
" :endfun
"
" Évidemment à adapter à ses besoins !

" Correcteur orthographique
set spelllang=en,fr
set spell
set spellsuggest=5
" Change highlighting of the misspelling because I can't read mistakes with
" originals colors and my color theme 
hi SpellBad ctermfg=015 ctermbg=013

" Intercepte ^u et ^w en mode insert (supprime la ligne courante et mot avant curseur, sans pouvoir annuler cette annulation, en gros la commande dessous permet de undo alors qu'on ne peut pas undo)
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Format de l'en-tête produit par la sortie de :hardcopy %<%f%h%m%=Page\ %N
" set printheader
" Convertir le fichier en fichier .html pour pouvoir l'imprimer depuis un navigateur (cmd commentées)
" source $VIMRUNTIME/syntax/2html.vim " conversion fichier courant, ouverture fenêtre à enr comd dessous :
" write ~/.vimrc.html
" x-www-browser ~/.vimrc.html " ouverture .vimrc dans un navigateur, imprimer depuis là.
