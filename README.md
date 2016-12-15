# Password Hasher

(Optional first step: create a file called `salt` with any random passphrase in it that you like. If you skip this step, a file will be generated for you, and you are free to change it later).

* Run the script:

```
./password.rb
```

* Enter the name the service of interest (case sensitive)

```
Service (e.g. Google):
```

For now, the result is always 12 characters, including letters/numbers/symbols. Hopeful future feature will allow length and character set configuration per service with a YML file. A line is printed letting you know what characters will be used to generate the password:

```
-> using characters: abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789`~!@#$%^&*()_+-=[]{}\|;:'",<.>/?
```

* Enter your master password (or whatever password you want to use for this service, if you wish to remember more than one password):

```
Master password: 
```

A service-specific password will then be generated and copied to the clipboard automatically.

* To use the script on multiple machines, be sure to copy the `salt` file along with you to each machine.