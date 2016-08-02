require 'test_helper'

class DX::LookupTest < Minitest::Test
  def setup
    @qrz = DX::Lookup::QRZ.new(ENV['QRZ_USERNAME'], ENV['QRZ_PASSWORD'])
  end

  def test_that_it_has_a_version_number
    refute_nil ::DX::Lookup::VERSION
  end

  def test_bad_qrz_session
    bad_qrz = DX::Lookup::QRZ.new('moo', 'cow')
    assert_raises DX::Lookup::QRZ::APIError do
      bad_qrz.create_session!
    end
  end

  def test_good_qrz_session
    refute_nil @qrz.create_session!
    refute_nil @qrz.session_key
  end

  def test_qrz_callsign_lookup
    assert_raises DX::Lookup::QRZ::APIError do
      @qrz.get_callsign('foobar')
    end

    call = @qrz.get_callsign('W1AW')
    assert_equal "W1AW", call.callsign
    assert_equal 291, call.dxcc
    assert_equal nil, call.first_name
    assert_equal "ARRL HQ OPERATORS CLUB", call.last_name
    assert_equal "225 MAIN ST", call.address_1
    assert_equal "NEWINGTON", call.address_2
    assert_equal "CT", call.address_state
    assert_equal "06111", call.address_zip
    assert_equal "United States", call.address_country
    assert_equal 271, call.address_dxcc # Weird value - should be 291?
    assert_equal "FN31pr", call.grid
    assert_equal "Hartford", call.county
    assert_equal "United States", call.dxcc_name
    assert_equal "09003", call.fips
    assert_equal "C", call.license_class
    assert_equal "HAB", call.license_codes
    assert_equal "W1AW@ARRL.ORG", call.email

    call = @qrz.get_callsign('WW1X')
    assert_equal true, call.qsl_accepted
    assert_equal false, call.eqsl_accepted
    assert_equal false, call.lotw_accepted
  end

  def test_qrz_entity_lookup
    assert_raises DX::Lookup::QRZ::APIError do
      @qrz.get_dxcc_entity(999)
    end

    entity = @qrz.get_dxcc_entity(291)
    assert_equal 291, entity.dxcc
    assert_equal "US", entity.code_short
    assert_equal "USA", entity.code_long
    assert_equal "United States", entity.name
    assert_equal "NA", entity.continent
    assert_equal 0, entity.itu_zone
    assert_equal 0, entity.cq_zone
    assert_equal -5, entity.time_zone
    assert_equal [37.701207, -97.316895], entity.coordinate
    assert_equal nil, entity.notes

    entity = @qrz.get_callsign_entity('W1AW')
    assert_equal 291, entity.dxcc
  end

  def test_qrz_all_entities_lookup
    entities = @qrz.get_all_entities

    assert_operator entities.count, :>, 100
    refute_nil entities.find { |e| e.dxcc == 291 }
  end
end
