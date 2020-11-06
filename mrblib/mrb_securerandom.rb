class SecureRandom
  class << self
    def random_bytes(n=nil)
      n = n ? n.to_int : 16

      if Module.const_defined?(:PolarSSL)
        @@entropy ||= PolarSSL::Entropy.new
        @@ctr_drbg ||= PolarSSL::CtrDrbg.new(@@entropy)
        return @@ctr_drbg.random_bytes(n)
      end

      begin
        File.open("/dev/urandom", 'r') {|f|
          ret = f.read(n)
          unless ret.length == n
            raise NotImplementedError, "Unexpected partial read from random device: only #{ret.length} for #{n} bytes"
          end
          return ret
        }
      rescue
        raise File::NoFileError, "No random device"
      end

      raise NotImplementedError, "No random device"
    end

    def hex(n=nil)
      random_bytes(n).unpack("H*")[0]
    end

    def base64(n=nil)
      [random_bytes(n)].pack("m*").gsub("\n", "")
    end

    def urlsafe_base64(n=nil, padding=false)
      s = base64.gsub("+", "-").gsub("/", "_")
      s.gsub!("=", "") unless padding
      s
    end

    def random_number(n=0)
      if 0 < n
        hex = n.to_s(16)
        hex = '0' + hex if (hex.length & 1) == 1
        bin = [hex].pack("H*")
        mask = bin[0].ord
        mask |= mask >> 1
        mask |= mask >> 2
        mask |= mask >> 4

        loop do
          rnd = random_bytes(bin.length)
          rnd[0] = (rnd[0].ord & mask).chr
          return rnd.unpack("H*")[0].hex if rnd < bin
        end
      else
        raise NotImplementedError
      end
    end

    def uuid
      ary = random_bytes(16).unpack("nnnnnnnn")
      ary[3] = (ary[3] & 0x0fff) | 0x4000
      ary[4] = (ary[4] & 0x3fff) | 0x8000
      "%04x%04x-%04x-%04x-%04x-%04x%04x%04x" % ary
    end
  end
end
