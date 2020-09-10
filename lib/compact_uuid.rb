# frozen_string_literal: true

# Converts a standard uuid (x-x-x-x-x) into a more efficient 16 byte.
class CompactUuid
  VALID_FORM = /(\w{8})-(\w{4})-(\w{4})-(\w{4})-(\w{12})/.freeze
  COMPACT_FORM = /(\w{8})(\w{4})(\w{4})(\w{4})(\w{12})/i.freeze

  def self.pack(unpacked_uuid)
    raise ArgumentError, 'Not a uuid' unless unpacked_uuid.match(VALID_FORM)

    [unpacked_uuid.tr('-', '')].pack('H*')
  end

  def self.unpack(packed_uuid)
    unpacked_nohypens = packed_uuid.unpack1('H*')
    parts = unpacked_nohypens.match(COMPACT_FORM)
    raise ArgumentError, 'Not a valid packed uuid' unless parts && parts.captures.length == 5

    parts.captures.join('-')
  end
end
