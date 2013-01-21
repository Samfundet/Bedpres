module PasswordResetHelper
  class MaxAttemptsReachedError < Exception; end
  class HashMismatchError < Exception; end
end