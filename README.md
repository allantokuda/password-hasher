# Password Hasher

1. Run the script `./password.rb`
2. Enter the name the service of interest (case sensitive)
3. Enter your master password (or whatever password you want to use for this service, if you wish to remember more than one password)

A service-specific password will then be generated and copied to the clipboard automatically. :tada:

## Details

* A `salt` file is also generated. This file is needed to reproduce the same passwords again in the future. To use the script on multiple machines, be sure to copy the generated `salt` file along with you to each machine. You are free to modify the `salt` file to contain whatever (preferably long) secret string you wish.
* For now, the result is always 12 characters, including letters/numbers/symbols. Hopeful future feature will allow length and character set configuration per service with a YML file.
