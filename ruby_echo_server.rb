require "socket"

svr = TCPServer.open(8000)
socks = [svr]

while true
	result = select(socks)
        next if result == nil
        for s in result[0]
        	if s == svr
			ns = s.accept
			socks.push(ns)
		else
			if s.eof?
                		s.close socks.delete(s)
			elsif str = s.readpartial(1024)
				s.write(str)
			end
		end
	end 
end
