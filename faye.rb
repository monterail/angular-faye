require 'faye'

bayeux = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)

bayeux.bind(:handshake) do |client_id|
  STDOUT.puts "HANDSHAKE #{client_id}"
end

bayeux.bind(:subscribe) do |client_id, channel|
  STDOUT.puts "SUBSCRIBE #{client_id} #{channel}"
end

bayeux.bind(:unsubscribe) do |client_id, channel|
  STDOUT.puts "UNSUBSCRIBE #{client_id} #{channel}"
end

bayeux.bind(:publish) do |client_id, channel, data|
  STDOUT.puts "PUBLISH #{client_id} #{channel} #{data}"
end

bayeux.bind(:disconnect) do |client_id|
  STDOUT.puts "DISCONNECT #{client_id}"
end

bayeux.listen(9292)
