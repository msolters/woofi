###
#       Template.WiFiSetup
###
Template.WiFiSetup.created = ->
  #
  # ( ) Initialize basic SoftAP objects and methods.
  #
  delete window.sap if window.sap?
  window.sap = new SoftAPSetup()
  @connectionStep = new ReactiveVar 'connectToFeeder'
  #
  # ( ) Variables for tracking attempts to connect to the Feeder
  #
  @locatingFeeder = new ReactiveVar false
  @setFeederConnectionState =
    connected: =>
      @locatingFeeder.set false
      @connectionStep.set 'chooseSSID'
      @scanAPs()
    disconnected: =>
      @locatingFeeder.set false
      @connectionStep.set 'connectToFeeder'
      Materialize.toast "We weren't able to find a Pet Feeder!  Make sure your computer's wireless network manager is properly connected to the Feeder via WiFi.", 7000, "red"
  #
  # This method returns the deviceInfo of the Photon.
  #
  @retrieveDeviceInfo = =>
    console.log "Retrieving device info..."
    sap.deviceInfo (err, dat) =>
      if !err
        if dat.id?
          console.log "Device info retrieved: #{dat}"
          @retrieveKey()
          return
      else
        @setFeederConnectionState.disconnected()
  @retrieveKey = =>
    console.log "Retrieving public key..."
    sap.publicKey (err, dat) =>
      throw err if err
      if !err
        console.log "Key retrieved: #{dat}"
        @setFeederConnectionState.connected()
      else
        @setFeederConnectionState.disconnected()
  #
  # ( ) Define SoftAP scanning methods and callbacks.
  #
  @scanningAPs = new ReactiveVar false
  @aps = new ReactiveVar []
  @selectedAP = new ReactiveVar false
  @scanAPs = =>
    if @scanningAPs.get()
      Materialize.toast "The Feeder is currently scanning for WiFi networks, please wait...", 3500, "teal"
      return
    @aps.set []
    @scanningAPs.set true
    console.log "Scanning APs..."
    sap.scan (err, dat) =>
      throw err if err
      console.log "Finished scanning: "
      console.log dat.scans
      @scanningAPs.set false
      @aps.set _.sortBy dat.scans, (_ap) ->
        -_ap.rssi

Template.WiFiSetup.helpers
  connectionStepIs: (_connectionState) ->
    return true if Template.instance().connectionStep.get() is _connectionState
    return false
  # SoftAP feeder location helpers.
  locatingFeeder: ->
    Template.instance().locatingFeeder.get()
  # SoftAP scanning helpers.
  aps: ->
    Template.instance().aps.get()
  selectedAP: ->
    Template.instance().selectedAP.get()
  scanningAPs: ->
    Template.instance().scanningAPs.get()
  securityType: (securityType_dec) ->
    sap.securityLookup securityType_dec
  isSelectedAP: (_ap) ->
    return true if Template.instance().selectedAP.get() is _ap
    return false

Template.WiFiSetup.events
  'click button#cancel': (event, template) ->
    AntiModals.dismissOverlay template.firstNode
  # SoftAP feeder location events.
  'click button[data-locate-feeder]': (event, template) ->
    template.locatingFeeder.set true
    template.retrieveDeviceInfo()
  # SoftAP scanning events.
  'click button[data-scan-aps]': (event, template) ->
    template.scanAPs()
  'click button[data-deselect-ssid]': (event, template) ->
    template.selectedAP.set false
  'click div.feeder-ssid-option': (event, template) ->
    return unless template.selectedAP.get() isnt @
    template.selectedAP.set @
  # SoftAP connection events.
  'submit form#connect-to-ssid': (event, template) ->
    _ap = template.selectedAP.get()
    connection_config =
      ssid: _ap.ssid
      channel: _ap.ch
      security: sap.securityLookup _ap.sec
    if _ap.sec
      connection_config.password = template.find("input#ssid-pw").value
    else
      connection_config.password = ""
    sap.configure connection_config, (err, dat) ->
      throw err if err
      console.log 'configured!!!'
      sap.connect (err, dat) ->
        throw err if err
        template.connectionStep.set 'pendingConnection'
        console.log 'connected!!!'
    return false
  # SoftAP pendingConnection events.
  'click button[data-restart-wifi-wizard]': (event, template) ->
    template.locatingFeeder.set false
    template.aps.set []
    template.selectedAP.set false
    template.scanningAPs.set false
    template.connectionStep.set 'connectToFeeder'

Template.WiFiSetup.destroyed = ->
  delete window.sap if window.sap?
