module DX
  module Lookup
    class QRZ
      class Callsign
        include Virtus.model

        attribute :callsign, String
        attribute :aliases, Array[String]
        attribute :dxcc, Integer
        attribute :first_name, String
        attribute :last_name, String
        attribute :address_1, String
        attribute :address_2, String
        attribute :address_state, String
        attribute :address_zip, String
        attribute :address_country, String
        attribute :address_dxcc, Integer
        attribute :coordinate, Array[Float]
        attribute :grid, String
        attribute :county, String
        attribute :dxcc_name, String
        attribute :effective_date, Date
        attribute :expiration_date, Date
        attribute :fips, String
        attribute :previous_callsign, String
        attribute :license_class, String
        attribute :license_codes, String
        attribute :qsl_info, String
        attribute :email, String
        attribute :url, String
        attribute :profile_views, Integer
        attribute :qsl_accepted, Boolean
        attribute :eqsl_accepted, Boolean
        attribute :lotw_accepted, Boolean
        attribute :cq_zone, Integer
        attribute :itu_zone, Integer
        attribute :birth_year, Integer
        attribute :qrz_admin, String
        attribute :iota, String
        attribute :geo_source, Symbol

        def self.from_response(xml)
          Callsign.new(
            :callsign => xml['call'],
            :aliases => xml['aliases'].to_s.split(','),
            :dxcc => xml['dxcc'],
            :first_name => xml['fname'],
            :last_name => xml['name'],
            :address_1 => xml['addr1'],
            :address_2 => xml['addr2'],
            :address_state => xml['state'],
            :address_zip => xml['zip'],
            :address_country => xml['country'],
            :address_dxcc => xml['ccode'],
            :coordinate => [xml['lat'], xml['lon']],
            :grid => xml['grid'],
            :county => xml['county'],
            :dxcc_name => xml['land'],
            :effective_date => xml['efdate'],
            :expiration_date => xml['expdate'],
            :fips => xml['fips'],
            :previous_callsign => xml['p_call'],
            :license_class => xml['class'],
            :license_codes => xml['codes'],
            :qsl_info => xml['qslmgr'],
            :email => xml['email'],
            :url => xml['url'],
            :profile_views => xml['u_views'],
            :eqsl_accepted => xml['eqsl'],
            :qsl_accepted => xml['mqsl'],
            :cq_zone => xml['cqzone'],
            :itu_zone => xml['ituzone'],
            :birth_year => xml['born'],
            :qrz_admin => xml['user'],
            :lotw_accepted => xml['lotw'],
            :iota => xml['iota'],
            :geo_source => xml['geoloc']
          )
        end
      end
    end
  end
end