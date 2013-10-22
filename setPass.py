import keyring
passWord = raw_input("Masukkan password baru")
keyring.set_password('Ubezee','admin',passWord)

