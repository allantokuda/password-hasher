require 'io/console'  # for 'noecho' method
require 'digest/sha2'
require 'clipboard'

LOWERCASE = 'abcdefghijklmnopqrstuvwxyz'
UPPERCASE = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
LETTERS = LOWERCASE + UPPERCASE
NUMBERS = '0123456789'
SYMBOLS  = '`~!@#$%^&*()_+-=[]{}\|;:\'",<.>/?'
PUNCTUATION = '.,;:?!()"'
ALL = LETTERS + NUMBERS + SYMBOLS

HEX = '0123456789abcdef'
SALT_FILE='salt'

print "Service (e.g. Google): "
service = gets

# TODO:
# - make these YML-configurable per service
# - pull defaults from an API of standard, known services
charset = ALL
passlen = 12

puts "-> using characters: #{charset}"

print "Master password: "
master_password = STDIN.noecho(&:gets).chomp
puts

salt = if File.file?(SALT_FILE)
         File.read(SALT_FILE)
       else
         rand(36**64).to_s(36).tap do |s|
           File.write(SALT_FILE, s)
         end
       end

secret = service + master_password + salt

password = Digest::SHA512.hexdigest(secret)    # 016ba8c4cfde65af99cb5fa8b8a37e2eb73f481b3ae34991666df2e04feb6c038666ebd1ec2b6f623967756033c702dde5f423f7d47ab6ed1827ff53783731f7
  .chars                                       # ["0", "1", "6", "b", "a", "8", "c", "4", "c", "f", "d", "e", "6", "5", "a", "f", "9", "9", "c", "b", "5", ...
  .each_slice(4)                               # #<Enumerator: ["0", "1", "6", "b", "a", "8", "c", "4", "c", "f", "d", "e", "6", ...
  .map(&:join)                                 # ["016b", "a8c4", "cfde", "65af", "99cb", "5fa8", "b8a3", ...
  .map { |hex| hex.to_i(16) }                  # [363, 43204, 53214, 26031, 39371, 24488, 47267, ...
  .map { |i| charset[i % charset.length] }     # ["i", "K", "J", "T", "L", ";", "0", ...
  .join                                        # iKJTL;0(Z"xswZlGQtMR)pXxjWiOgRGl
  .slice(0, passlen)                           # iKJTL;0(Z"xs

Clipboard.copy password
print 'Password copied to clipboard.'
