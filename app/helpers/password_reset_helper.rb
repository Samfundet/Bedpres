module PasswordResetHelper
  class MaxAttemptsReachedError < Exception; end
  class HashMismatchError < Exception; end
  class PasswordMismatchError < Exception; end
end
