class EventMachine::SFlow::Datagram
  attr_reader :version, :agent, :sub_agent_id, :datagram_sequence, :uptime, :samples, :sample_count
  
  def initialize data
    data.extend EM::SFlow::BinaryString
    
    @samples = []

    @version, ip_version = data.unpack("NN")
    
    data.advance(8)

    if ip_version == 1
      @agent = IPAddr.new(data.unpack("N").first, Socket::AF_INET)
      data.advance(4)
    else
      ip_elements = data.unpack("NNNN")
      @agent = IPAddr.new((ip_elements[0] << 96) + (ip_elements[1] << 64) + (ip_elements[2] << 32) + ip_elements[3], Socket::AF_INET6)
      data.advance(16)
    end
    
    @datagram_sequence, @uptime, @sample_count = data.unpack("NNN")
    data.advance(12)

    sample_count.times do
      format, = data.unpack("N")
      data.advance(4)
      enterprise = 0

      if enterprise == 0 && format == 1
        @samples << EM::SFlow::FlowSample.new(data)
      elsif enterprise == 0 && format == 2  
        # @samples << EM::SFlow::CounterSample.new(data)
      elsif enterprise == 0 && format == 3
        # @samples << EM::SFlow::ExpandedFlowSample.new(data)
      elsif enterprise == 0 && format == 4
        # @samples << EM::SFlow::ExpandedCounterSample.new(data)
      end
    end
  end
end
