import keyring
password = keyring.get_password('Ubezee','admin')
print(password)
passWord = raw_input("Masukkan password baru")
keyring.set_password('Ubezee','admin',passWord)

