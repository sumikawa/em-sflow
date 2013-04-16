class EventMachine::SFlow::RawPacketHeader
  attr_accessor :protocol, :frame_length, :strip_count, :header_length, :header
  
  def initialize data
    data.extend EventMachine::SFlow::BinaryString
    
    @protocol, @frame_length, @header_length = data.unpack("NNN")
    data.advance(12)

    @header = data
    data.advance(@header_length)
  end
end
