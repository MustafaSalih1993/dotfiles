function up

doas emerge -avuUD @world
doas emerge --depclean

end
