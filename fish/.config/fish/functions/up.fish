function up

doas emerge-webrsync
doas emerge -aqvuND --with-bdeps=y @world
doas emerge --depclean

end
