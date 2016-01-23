class SecureRandom
  def self.random_bytes(n=nil)
     n = n ? n.to_int : 16

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
end
