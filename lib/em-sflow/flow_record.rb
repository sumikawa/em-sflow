module EventMachine
  module SFlow
    module FlowRecord
      def to_flow_records!(record_count)
        records = []
        record_count.times do
          sample_type, = unpack("N")
          self.advance(4)

          enterprise = 0;
          format = sample_type

          if enterprise == 0 && format == 1
            records << EM::SFlow::RawPacketHeader.new(self)
          elsif enterprise == 0 && format == 2
            records << EM::SFlow::IPv4Data.new(self)
          elsif enterprise == 0 && format == 3
            records << EM::SFlow::IPv6Data.new(self)
          elsif enterprise == 0 && format == 4
            # records << EM::SFlow::IPv6Data.new(self)
          elsif enterprise == 0 && format == 1001
            # records << EM::SFlow::ExtendedSwitchData.new(self)
          elsif enterprise == 0 && format == 1002
            # records << EM::SFlow::ExtendedRouterData.new(self)
          elsif enterprise == 0 && format == 1003
            # records << EM::SFlow::ExtendedGatewayData.new(self)
          elsif enterprise == 0 && format == 1004
            # records << EM::SFlow::ExtendedUserData.new(self)
          elsif enterprise == 0 && format == 1005
            # records << EM::SFlow::ExtendedUrlData.new(self)
          elsif enterprise == 0 && format == 1006
            # records << EM::SFlow::ExtendedMplsData.new(self)
          elsif enterprise == 0 && format == 1007
            # records << EM::SFlow::ExtendedNatData.new(self)
          elsif enterprise == 0 && format == 1008
            # records << EM::SFlow::ExtendedMplsTunnel.new(self)
          elsif enterprise == 0 && format == 1009
            # records << EM::SFlow::ExtendedMplsVc.new(self)
          elsif enterprise == 0 && format == 1010
            # records << EM::SFlow::ExtendedMplsFec.new(self)
          elsif enterprise == 0 && format == 1011
            # records << EM::SFlow::ExtendedMplsLvpFec.new(self)
          elsif enterprise == 0 && format == 1012
            # records << EM::SFlow::ExtendedVlanTunnel.new(self)
          end
        end
        
        records
      end
    end
  end
end
