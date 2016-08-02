module DX
  module Lookup
    class QRZ
      class Entity
        include Virtus.model

        attribute :dxcc, Integer
        attribute :code_short, String
        attribute :code_long, String
        attribute :name, String
        attribute :continent, String
        attribute :itu_zone, Integer
        attribute :cq_zone, Integer
        attribute :time_zone, Integer
        attribute :coordinate, Array[Float]
        attribute :notes, String

        def self.from_response(xml)
          Entity.new(
            :dxcc => xml['dxcc'],
            :code_short => xml['cc'],
            :code_long => xml['ccc'],
            :name => xml['name'],
            :continent => xml['continent'],
            :itu_zone => xml['ituzone'],
            :cq_zone => xml['cqzone'],
            :time_zone => xml['timezone'],
            :coordinate => [xml['lat'], xml['lon']],
            :notes => xml['notes']
          )
        end
      end
    end
  end
end