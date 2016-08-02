require_relative 'qrz/callsign'
require_relative 'qrz/entity'

module DX
  module Lookup
    class QRZ
      class APIError < StandardError; end

      include HTTParty

      API_VERSION = '1.33'
      AGENT = "dx-lookup-#{DX::Lookup::VERSION}"

      base_uri "xmldata.qrz.com/xml/#{API_VERSION}/"

      attr_reader :session_key

      def initialize(username, password, options={})
        @username, @password = username, password
      end

      def get_callsign(callsign)
        login_if_needed!
        uri = construct_uri(:callsign => callsign)
        response = self.class.get(uri).parsed_response
        check_for_error(response)

        callsign_response = response['QRZDatabase']['Callsign']
        Callsign.from_response(callsign_response)
      end

      def get_dxcc_entity(dxcc)
        get_entities(dxcc.to_s).first
      end

      def get_all_entities
        get_entities('all')
      end

      def get_callsign_entity(callsign)
        get_entities(callsign).first
      end

      def create_session!
        uri = construct_uri(:username => @username, :password => @password, :agent => AGENT)
        response = self.class.get(uri)
        response = response.parsed_response
        check_for_error(response)

        @session_key = response['QRZDatabase']['Session']['Key']
      end

    protected

      def construct_uri(params={})
        params = params.merge(:s => session_key) if session_key && !params[:s]
        "?#{params.map { |k, v| "#{k}=#{v}" }.join(';')}"
      end

      def login_if_needed!
        create_session! unless session_key
      end

      def check_for_error(parsed_response)
        error = parsed_response['QRZDatabase']['Session']['Error']
        message = parsed_response['QRZDatabase']['Session']['Message']
        raise(APIError, message || error) if error
      end

      def get_entities(callsign)
        login_if_needed!
        uri = construct_uri(:dxcc => callsign)
        response = self.class.get(uri).parsed_response
        check_for_error(response)
        
        dxccs = [response['QRZDatabase']['DXCC']].flatten
        dxccs.map { |dxcc| Entity.from_response(dxcc) }
      end
    end
  end
end