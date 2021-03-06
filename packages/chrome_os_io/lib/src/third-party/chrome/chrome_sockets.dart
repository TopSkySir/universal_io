// Copy-pasted from:
// https://github.com/dart-gde/chrome.dart/
//
// The original license was:
//
//  The BSD 2-Clause License
//  http://www.opensource.org/licenses/bsd-license.php
//
//  Copyright (c) 2012, The chrome_vm.dart project authors
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those
//  of the authors and should not be interpreted as representing official policies,
//      either expressed or implied, of the FreeBSD Project.

/* This file has been generated - do not edit */

library chrome.sockets;

import 'chrome_common.dart';

final ChromeSockets sockets = ChromeSockets._();

AcceptErrorInfo _createAcceptErrorInfo(JsObject jsProxy) =>
    jsProxy == null ? null : AcceptErrorInfo.fromProxy(jsProxy);

AcceptInfo _createAcceptInfo(JsObject jsProxy) =>
    jsProxy == null ? null : AcceptInfo.fromProxy(jsProxy);

ArrayBuffer _createArrayBuffer(/*JsObject*/ jsProxy) =>
    jsProxy == null ? null : ArrayBuffer.fromProxy(jsProxy);

CreateInfo _createCreateInfo(JsObject jsProxy) =>
    jsProxy == null ? null : CreateInfo.fromProxy(jsProxy);

ReceiveErrorInfo _createReceiveErrorInfo(JsObject jsProxy) =>
    jsProxy == null ? null : ReceiveErrorInfo.fromProxy(jsProxy);

ReceiveInfo _createReceiveInfo(JsObject jsProxy) =>
    jsProxy == null ? null : ReceiveInfo.fromProxy(jsProxy);

SendInfo _createSendInfo(JsObject jsProxy) =>
    jsProxy == null ? null : SendInfo.fromProxy(jsProxy);

SocketInfo _createSocketInfo(JsObject jsProxy) =>
    jsProxy == null ? null : SocketInfo.fromProxy(jsProxy);

TLSVersionConstraints _createTLSVersionConstraints(JsObject jsProxy) =>
    jsProxy == null ? null : TLSVersionConstraints.fromProxy(jsProxy);

/// Data from an `onAcceptError` event.
class AcceptErrorInfo extends ChromeObject {
  AcceptErrorInfo({int socketId, int resultCode}) {
    if (socketId != null) this.socketId = socketId;
    if (resultCode != null) this.resultCode = resultCode;
  }

  AcceptErrorInfo.fromProxy(JsObject jsProxy) : super.fromProxy(jsProxy);

  int get resultCode => jsProxy['resultCode'];

  set resultCode(int value) => jsProxy['resultCode'] = value;

  int get socketId => jsProxy['socketId'];

  set socketId(int value) => jsProxy['socketId'] = value;
}

/// Data from an `onAccept` event.
class AcceptInfo extends ChromeObject {
  AcceptInfo({int socketId, int clientSocketId}) {
    if (socketId != null) this.socketId = socketId;
    if (clientSocketId != null) this.clientSocketId = clientSocketId;
  }

  AcceptInfo.fromProxy(JsObject jsProxy) : super.fromProxy(jsProxy);

  int get clientSocketId => jsProxy['clientSocketId'];

  set clientSocketId(int value) => jsProxy['clientSocketId'] = value;

  int get socketId => jsProxy['socketId'];

  set socketId(int value) => jsProxy['socketId'] = value;
}

class ChromeSockets {
  /// Accessor for the `chrome.sockets.tcp` namespace.
  final ChromeSocketsTcp tcp = ChromeSocketsTcp._();

  /// Accessor for the `chrome.sockets.tcpServer` namespace.
  final ChromeSocketsTcpServer tcpServer = ChromeSocketsTcpServer._();

  /// Accessor for the `chrome.sockets.udp` namespace.
  final ChromeSocketsUdp udp = ChromeSocketsUdp._();

  ChromeSockets._();
}

/// Use the `chrome.sockets.tcp` API to send and receive data over the network
/// using TCP connections. This API supersedes the TCP functionality previously
/// found in the `chrome.socket` API.
class ChromeSocketsTcp extends ChromeApi {
  ChromeStreamController<ReceiveInfo> _onReceive;

  ChromeStreamController<ReceiveErrorInfo> _onReceiveError;
  ChromeSocketsTcp._() {
    var getApi = () => _sockets_tcp;
    _onReceive = ChromeStreamController<ReceiveInfo>.oneArg(
        getApi, 'onReceive', _createReceiveInfo);
    _onReceiveError = ChromeStreamController<ReceiveErrorInfo>.oneArg(
        getApi, 'onReceiveError', _createReceiveErrorInfo);
  }

  @override
  bool get available => _sockets_tcp != null;
  Stream<ReceiveInfo> get onReceive => _onReceive.stream;

  Stream<ReceiveErrorInfo> get onReceiveError => _onReceiveError.stream;

  JsObject get _sockets_tcp => chrome['sockets']['tcp'];

  /// Closes the socket and releases the address/port the socket is bound to.
  /// Each socket created should be closed after use. The socket id is no no
  /// longer valid as soon at the function is called. However, the socket is
  /// guaranteed to be closed only when the callback is invoked.
  /// [socketId]: The socket identifier.
  /// [callback]: Called when the `close` operation completes.
  Future close(int socketId) {
    if (_sockets_tcp == null) _throwNotAvailable();

    var completer = ChromeCompleter.noArgs();
    _sockets_tcp.callMethod('close', [socketId, completer.callback]);
    return completer.future;
  }

  /// Connects the socket to a remote machine. When the `connect` operation
  /// completes successfully, `onReceive` events are raised when data is received
  /// from the peer. If a network error occurs while the runtime is receiving
  /// packets, a `onReceiveError` event is raised, at which point no more
  /// `onReceive` event will be raised for this socket until the `resume` method
  /// is called.
  /// [socketId]: The socket identifier.
  /// [peerAddress]: The address of the remote machine. DNS name, IPv4 and IPv6
  /// formats are supported.
  /// [peerPort]: The port of the remote machine.
  /// [callback]: Called when the connect attempt is complete.
  ///
  /// Returns:
  /// Callback from the `connect` method.
  /// [result]: The result code returned from the underlying network call. A
  /// negative value indicates an error.
  Future<int> connect(int socketId, String peerAddress, int peerPort) {
    if (_sockets_tcp == null) _throwNotAvailable();

    var completer = ChromeCompleter<int>.oneArg();
    _sockets_tcp.callMethod(
        'connect', [socketId, peerAddress, peerPort, completer.callback]);
    return completer.future;
  }

  /// Creates a TCP socket.
  /// [properties]: The socket properties (optional).
  /// [callback]: Called when the socket has been created.
  ///
  /// Returns:
  /// Callback from the `create` method.
  /// [createInfo]: The result of the socket creation.
  Future<CreateInfo> create([SocketProperties properties]) {
    if (_sockets_tcp == null) _throwNotAvailable();

    var completer = ChromeCompleter<CreateInfo>.oneArg(_createCreateInfo);
    _sockets_tcp.callMethod('create', [jsify(properties), completer.callback]);
    return completer.future;
  }

  /// Disconnects the socket.
  /// [socketId]: The socket identifier.
  /// [callback]: Called when the disconnect attempt is complete.
  Future disconnect(int socketId) {
    if (_sockets_tcp == null) _throwNotAvailable();

    var completer = ChromeCompleter.noArgs();
    _sockets_tcp.callMethod('disconnect', [socketId, completer.callback]);
    return completer.future;
  }

  /// Retrieves the state of the given socket.
  /// [socketId]: The socket identifier.
  /// [callback]: Called when the socket state is available.
  ///
  /// Returns:
  /// Callback from the `getInfo` method.
  /// [socketInfo]: Object containing the socket information.
  Future<SocketInfo> getInfo(int socketId) {
    if (_sockets_tcp == null) _throwNotAvailable();

    var completer = ChromeCompleter<SocketInfo>.oneArg(_createSocketInfo);
    _sockets_tcp.callMethod('getInfo', [socketId, completer.callback]);
    return completer.future;
  }

  /// Retrieves the list of currently opened sockets owned by the application.
  /// [callback]: Called when the list of sockets is available.
  ///
  /// Returns:
  /// Callback from the `getSockets` method.
  /// [socketInfos]: Array of object containing socket information.
  Future<List<SocketInfo>> getSockets() {
    if (_sockets_tcp == null) _throwNotAvailable();

    var completer = ChromeCompleter<List<SocketInfo>>.oneArg(
        (e) => listify(e, _createSocketInfo));
    _sockets_tcp.callMethod('getSockets', [completer.callback]);
    return completer.future;
  }

  /// Start a TLS client connection over the connected TCP client socket.
  /// [socketId]: The existing, connected socket to use.
  /// [options]: Constraints and parameters for the TLS connection.
  /// [callback]: Called when the connection attempt is complete.
  Future<int> secure(int socketId, [SecureOptions options]) {
    if (_sockets_tcp == null) _throwNotAvailable();

    var completer = ChromeCompleter<int>.oneArg();
    _sockets_tcp
        .callMethod('secure', [socketId, jsify(options), completer.callback]);
    return completer.future;
  }

  /// Sends data on the given TCP socket.
  /// [socketId]: The socket identifier.
  /// [data]: The data to send.
  /// [callback]: Called when the `send` operation completes.
  ///
  /// Returns:
  /// Callback from the `send` method.
  /// [sendInfo]: Result of the `send` method.
  Future<SendInfo> send(int socketId, ArrayBuffer data) {
    if (_sockets_tcp == null) _throwNotAvailable();

    var completer = ChromeCompleter<SendInfo>.oneArg(_createSendInfo);
    _sockets_tcp
        .callMethod('send', [socketId, jsify(data), completer.callback]);
    return completer.future;
  }

  /// Enables or disables the keep-alive functionality for a TCP connection.
  /// [socketId]: The socket identifier.
  /// [enable]: If true, enable keep-alive functionality.
  /// [delay]: Set the delay seconds between the last data packet received and
  /// the first keepalive probe. Default is 0.
  /// [callback]: Called when the setKeepAlive attempt is complete.
  ///
  /// Returns:
  /// Callback from the `setKeepAliveCallback` method.
  /// [result]: The result code returned from the underlying network call. A
  /// negative value indicates an error.
  Future<int> setKeepAlive(int socketId, bool enable, [int delay]) {
    if (_sockets_tcp == null) _throwNotAvailable();

    var completer = ChromeCompleter<int>.oneArg();
    _sockets_tcp.callMethod(
        'setKeepAlive', [socketId, enable, delay, completer.callback]);
    return completer.future;
  }

  /// Sets or clears `TCP_NODELAY` for a TCP connection. Nagle's algorithm will
  /// be disabled when `TCP_NODELAY` is set.
  /// [socketId]: The socket identifier.
  /// [noDelay]: If true, disables Nagle's algorithm.
  /// [callback]: Called when the setNoDelay attempt is complete.
  ///
  /// Returns:
  /// Callback from the `setNodeDelay` method.
  /// [result]: The result code returned from the underlying network call. A
  /// negative value indicates an error.
  Future<int> setNoDelay(int socketId, bool noDelay) {
    if (_sockets_tcp == null) _throwNotAvailable();

    var completer = ChromeCompleter<int>.oneArg();
    _sockets_tcp
        .callMethod('setNoDelay', [socketId, noDelay, completer.callback]);
    return completer.future;
  }

  /// Enables or disables the application from receiving messages from its peer.
  /// The default value is "false". Pausing a socket is typically used by an
  /// application to throttle data sent by its peer. When a socket is paused, no
  /// `onReceive` event is raised. When a socket is connected and un-paused,
  /// `onReceive` events are raised again when messages are received.
  Future setPaused(int socketId, bool paused) {
    if (_sockets_tcp == null) _throwNotAvailable();

    var completer = ChromeCompleter.noArgs();
    _sockets_tcp
        .callMethod('setPaused', [socketId, paused, completer.callback]);
    return completer.future;
  }

  /// Updates the socket properties.
  /// [socketId]: The socket identifier.
  /// [properties]: The properties to update.
  /// [callback]: Called when the properties are updated.
  Future update(int socketId, SocketProperties properties) {
    if (_sockets_tcp == null) _throwNotAvailable();

    var completer = ChromeCompleter.noArgs();
    _sockets_tcp.callMethod(
        'update', [socketId, jsify(properties), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw UnsupportedError("'chrome.sockets.tcp' is not available");
  }
}

/// Use the `chrome.sockets.tcpServer` API to create server applications using
/// TCP connections. This API supersedes the TCP functionality previously found
/// in the `chrome.socket` API.
class ChromeSocketsTcpServer extends ChromeApi {
  ChromeStreamController<AcceptInfo> _onAccept;

  ChromeStreamController<AcceptErrorInfo> _onAcceptError;
  ChromeSocketsTcpServer._() {
    var getApi = () => _sockets_tcpServer;
    _onAccept = ChromeStreamController<AcceptInfo>.oneArg(
        getApi, 'onAccept', _createAcceptInfo);
    _onAcceptError = ChromeStreamController<AcceptErrorInfo>.oneArg(
        getApi, 'onAcceptError', _createAcceptErrorInfo);
  }

  @override
  bool get available => _sockets_tcpServer != null;
  Stream<AcceptInfo> get onAccept => _onAccept.stream;

  Stream<AcceptErrorInfo> get onAcceptError => _onAcceptError.stream;

  JsObject get _sockets_tcpServer => chrome['sockets']['tcpServer'];

  /// Disconnects and destroys the socket. Each socket created should be closed
  /// after use. The socket id is no longer valid as soon at the function is
  /// called. However, the socket is guaranteed to be closed only when the
  /// callback is invoked.
  /// [socketId]: The socket identifier.
  /// [callback]: Called when the `close` operation completes.
  Future close(int socketId) {
    if (_sockets_tcpServer == null) _throwNotAvailable();

    var completer = ChromeCompleter.noArgs();
    _sockets_tcpServer.callMethod('close', [socketId, completer.callback]);
    return completer.future;
  }

  /// Creates a TCP server socket.
  /// [properties]: The socket properties (optional).
  /// [callback]: Called when the socket has been created.
  ///
  /// Returns:
  /// Callback from the `create` method.
  /// [createInfo]: The result of the socket creation.
  Future<CreateInfo> create([SocketProperties properties]) {
    if (_sockets_tcpServer == null) _throwNotAvailable();

    var completer = ChromeCompleter<CreateInfo>.oneArg(_createCreateInfo);
    _sockets_tcpServer
        .callMethod('create', [jsify(properties), completer.callback]);
    return completer.future;
  }

  /// Disconnects the listening socket, i.e. stops accepting new connections and
  /// releases the address/port the socket is bound to. The socket identifier
  /// remains valid, e.g. it can be used with `listen` to accept connections on a
  /// new port and address.
  /// [socketId]: The socket identifier.
  /// [callback]: Called when the disconnect attempt is complete.
  Future disconnect(int socketId) {
    if (_sockets_tcpServer == null) _throwNotAvailable();

    var completer = ChromeCompleter.noArgs();
    _sockets_tcpServer.callMethod('disconnect', [socketId, completer.callback]);
    return completer.future;
  }

  /// Retrieves the state of the given socket.
  /// [socketId]: The socket identifier.
  /// [callback]: Called when the socket state is available.
  ///
  /// Returns:
  /// Callback from the `getInfo` method.
  /// [socketInfo]: Object containing the socket information.
  Future<SocketInfo> getInfo(int socketId) {
    if (_sockets_tcpServer == null) _throwNotAvailable();

    var completer = ChromeCompleter<SocketInfo>.oneArg(_createSocketInfo);
    _sockets_tcpServer.callMethod('getInfo', [socketId, completer.callback]);
    return completer.future;
  }

  /// Retrieves the list of currently opened sockets owned by the application.
  /// [callback]: Called when the list of sockets is available.
  ///
  /// Returns:
  /// Callback from the `getSockets` method.
  /// [socketInfos]: Array of object containing socket information.
  Future<List<SocketInfo>> getSockets() {
    if (_sockets_tcpServer == null) _throwNotAvailable();

    var completer = ChromeCompleter<List<SocketInfo>>.oneArg(
        (e) => listify(e, _createSocketInfo));
    _sockets_tcpServer.callMethod('getSockets', [completer.callback]);
    return completer.future;
  }

  /// Listens for connections on the specified port and address. If the
  /// port/address is in use, the callback indicates a failure.
  /// [socketId]: The socket identifier.
  /// [address]: The address of the local machine.
  /// [port]: The port of the local machine. When set to `0`, a free port is
  /// chosen dynamically. The dynamically allocated port can be found by calling
  /// `getInfo`.
  /// [backlog]: Length of the socket's listen queue. The default value depends
  /// on the Operating System (SOMAXCONN), which ensures a reasonable queue
  /// length for most applications.
  /// [callback]: Called when listen operation completes.
  ///
  /// Returns:
  /// Callback from the `listen` method.
  /// [result]: The result code returned from the underlying network call. A
  /// negative value indicates an error.
  Future<int> listen(int socketId, String address, int port, [int backlog]) {
    if (_sockets_tcpServer == null) _throwNotAvailable();

    var completer = ChromeCompleter<int>.oneArg();
    _sockets_tcpServer.callMethod(
        'listen', [socketId, address, port, backlog, completer.callback]);
    return completer.future;
  }

  /// Enables or disables a listening socket from accepting new connections. When
  /// paused, a listening socket accepts new connections until its backlog (see
  /// `listen` function) is full then refuses additional connection requests.
  /// `onAccept` events are raised only when the socket is un-paused.
  Future setPaused(int socketId, bool paused) {
    if (_sockets_tcpServer == null) _throwNotAvailable();

    var completer = ChromeCompleter.noArgs();
    _sockets_tcpServer
        .callMethod('setPaused', [socketId, paused, completer.callback]);
    return completer.future;
  }

  /// Updates the socket properties.
  /// [socketId]: The socket identifier.
  /// [properties]: The properties to update.
  /// [callback]: Called when the properties are updated.
  Future update(int socketId, SocketProperties properties) {
    if (_sockets_tcpServer == null) _throwNotAvailable();

    var completer = ChromeCompleter.noArgs();
    _sockets_tcpServer.callMethod(
        'update', [socketId, jsify(properties), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw UnsupportedError("'chrome.sockets.tcpServer' is not available");
  }
}

/// Use the `chrome.sockets.udp` API to send and receive data over the network
/// using UDP connections. This API supersedes the UDP functionality previously
/// found in the "socket" API.
class ChromeSocketsUdp extends ChromeApi {
  ChromeStreamController<ReceiveInfo> _onReceive;

  ChromeStreamController<ReceiveErrorInfo> _onReceiveError;
  ChromeSocketsUdp._() {
    var getApi = () => _sockets_udp;
    _onReceive = ChromeStreamController<ReceiveInfo>.oneArg(
        getApi, 'onReceive', _createReceiveInfo);
    _onReceiveError = ChromeStreamController<ReceiveErrorInfo>.oneArg(
        getApi, 'onReceiveError', _createReceiveErrorInfo);
  }

  @override
  bool get available => _sockets_udp != null;
  Stream<ReceiveInfo> get onReceive => _onReceive.stream;

  Stream<ReceiveErrorInfo> get onReceiveError => _onReceiveError.stream;

  JsObject get _sockets_udp => chrome['sockets']['udp'];

  /// Binds the local address and port for the socket. For a client socket, it is
  /// recommended to use port 0 to let the platform pick a free port.
  ///
  /// Once the `bind` operation completes successfully, `onReceive` events are
  /// raised when UDP packets arrive on the address/port specified -- unless the
  /// socket is paused.
  ///
  /// [socketId]: The socket ID.
  /// [address]: The address of the local machine. DNS name, IPv4 and IPv6
  /// formats are supported. Use "0.0.0.0" to accept packets from all local
  /// available network interfaces.
  /// [port]: The port of the local machine. Use "0" to bind to a free port.
  /// [callback]: Called when the `bind` operation completes.
  ///
  /// Returns:
  /// Callback from the `bind` method.
  /// [result]: The result code returned from the underlying network call. A
  /// negative value indicates an error.
  Future<int> bind(int socketId, String address, int port) {
    if (_sockets_udp == null) _throwNotAvailable();

    var completer = ChromeCompleter<int>.oneArg();
    _sockets_udp
        .callMethod('bind', [socketId, address, port, completer.callback]);
    return completer.future;
  }

  /// Closes the socket and releases the address/port the socket is bound to.
  /// Each socket created should be closed after use. The socket id is no longer
  /// valid as soon at the function is called. However, the socket is guaranteed
  /// to be closed only when the callback is invoked.
  /// [socketId]: The socket ID.
  /// [callback]: Called when the `close` operation completes.
  Future close(int socketId) {
    if (_sockets_udp == null) _throwNotAvailable();

    var completer = ChromeCompleter.noArgs();
    _sockets_udp.callMethod('close', [socketId, completer.callback]);
    return completer.future;
  }

  /// Creates a UDP socket with the given properties.
  /// [properties]: The socket properties (optional).
  /// [callback]: Called when the socket has been created.
  ///
  /// Returns:
  /// Callback from the `create` method.
  /// [createInfo]: The result of the socket creation.
  Future<CreateInfo> create([SocketProperties properties]) {
    if (_sockets_udp == null) _throwNotAvailable();

    var completer = ChromeCompleter<CreateInfo>.oneArg(_createCreateInfo);
    _sockets_udp.callMethod('create', [jsify(properties), completer.callback]);
    return completer.future;
  }

  /// Retrieves the state of the given socket.
  /// [socketId]: The socket ID.
  /// [callback]: Called when the socket state is available.
  ///
  /// Returns:
  /// Callback from the `getInfo` method.
  /// [socketInfo]: Object containing the socket information.
  Future<SocketInfo> getInfo(int socketId) {
    if (_sockets_udp == null) _throwNotAvailable();

    var completer = ChromeCompleter<SocketInfo>.oneArg(_createSocketInfo);
    _sockets_udp.callMethod('getInfo', [socketId, completer.callback]);
    return completer.future;
  }

  /// Gets the multicast group addresses the socket is currently joined to.
  /// [socketId]: The socket ID.
  /// [callback]: Called with an array of strings of the result.
  ///
  /// Returns:
  /// Callback from the `getJoinedGroupsCallback` method.
  /// [groups]: Array of groups the socket joined.
  Future<List<String>> getJoinedGroups(int socketId) {
    if (_sockets_udp == null) _throwNotAvailable();

    var completer = ChromeCompleter<List<String>>.oneArg(listify);
    _sockets_udp.callMethod('getJoinedGroups', [socketId, completer.callback]);
    return completer.future;
  }

  /// Retrieves the list of currently opened sockets owned by the application.
  /// [callback]: Called when the list of sockets is available.
  ///
  /// Returns:
  /// Callback from the `getSockets` method.
  /// [socketInfos]: Array of object containing socket information.
  Future<List<SocketInfo>> getSockets() {
    if (_sockets_udp == null) _throwNotAvailable();

    var completer = ChromeCompleter<List<SocketInfo>>.oneArg(
        (e) => listify(e, _createSocketInfo));
    _sockets_udp.callMethod('getSockets', [completer.callback]);
    return completer.future;
  }

  /// Joins the multicast group and starts to receive packets from that group.
  /// The socket must be bound to a local port before calling this method.
  /// [socketId]: The socket ID.
  /// [address]: The group address to join. Domain names are not supported.
  /// [callback]: Called when the `joinGroup` operation completes.
  ///
  /// Returns:
  /// Callback from the `joinGroup` method.
  /// [result]: The result code returned from the underlying network call. A
  /// negative value indicates an error.
  Future<int> joinGroup(int socketId, String address) {
    if (_sockets_udp == null) _throwNotAvailable();

    var completer = ChromeCompleter<int>.oneArg();
    _sockets_udp
        .callMethod('joinGroup', [socketId, address, completer.callback]);
    return completer.future;
  }

  /// Leaves the multicast group previously joined using `joinGroup`. This is
  /// only necessary to call if you plan to keep using the socketafterwards,
  /// since it will be done automatically by the OS when the socket is closed.
  ///
  /// Leaving the group will prevent the router from sending multicast datagrams
  /// to the local host, presuming no other process on the host is still joined
  /// to the group.
  ///
  /// [socketId]: The socket ID.
  /// [address]: The group address to leave. Domain names are not supported.
  /// [callback]: Called when the `leaveGroup` operation completes.
  ///
  /// Returns:
  /// Callback from the `leaveGroup` method.
  /// [result]: The result code returned from the underlying network call. A
  /// negative value indicates an error.
  Future<int> leaveGroup(int socketId, String address) {
    if (_sockets_udp == null) _throwNotAvailable();

    var completer = ChromeCompleter<int>.oneArg();
    _sockets_udp
        .callMethod('leaveGroup', [socketId, address, completer.callback]);
    return completer.future;
  }

  /// Sends data on the given socket to the given address and port. The socket
  /// must be bound to a local port before calling this method.
  /// [socketId]: The socket ID.
  /// [data]: The data to send.
  /// [address]: The address of the remote machine.
  /// [port]: The port of the remote machine.
  /// [callback]: Called when the `send` operation completes.
  ///
  /// Returns:
  /// Callback from the `send` method.
  /// [sendInfo]: Result of the `send` method.
  Future<SendInfo> send(
      int socketId, ArrayBuffer data, String address, int port) {
    if (_sockets_udp == null) _throwNotAvailable();

    var completer = ChromeCompleter<SendInfo>.oneArg(_createSendInfo);
    _sockets_udp.callMethod(
        'send', [socketId, jsify(data), address, port, completer.callback]);
    return completer.future;
  }

  /// Enables or disables broadcast packets on this socket.
  ///
  /// [socketId]: The socket ID.
  /// [enabled]: `true` to enable broadcast packets, `false` to disable them.
  ///
  /// Returns:
  /// Callback from the `setBroadcast` method.
  /// [result]: The result code returned from the underlying network call.
  Future<int> setBroadcast(int socketId, bool enabled) {
    if (_sockets_udp == null) _throwNotAvailable();

    var completer = ChromeCompleter<int>.oneArg();
    _sockets_udp
        .callMethod('setBroadcast', [socketId, enabled, completer.callback]);
    return completer.future;
  }

  /// Sets whether multicast packets sent from the host to the multicast group
  /// will be looped back to the host.
  ///
  /// Note: the behavior of `setMulticastLoopbackMode` is slightly different
  /// between Windows and Unix-like systems. The inconsistency happens only when
  /// there is more than one application on the same host joined to the same
  /// multicast group while having different settings on multicast loopback mode.
  /// On Windows, the applications with loopback off will not RECEIVE the
  /// loopback packets; while on Unix-like systems, the applications with
  /// loopback off will not SEND the loopback packets to other applications on
  /// the same host. See MSDN: http://goo.gl/6vqbj
  ///
  /// Calling this method does not require multicast permissions.
  ///
  /// [socketId]: The socket ID.
  /// [enabled]: Indicate whether to enable loopback mode.
  /// [callback]: Called when the configuration operation completes.
  ///
  /// Returns:
  /// Callback from the `setMulticastLoopbackMode` method.
  /// [result]: The result code returned from the underlying network call. A
  /// negative value indicates an error.
  Future<int> setMulticastLoopbackMode(int socketId, bool enabled) {
    if (_sockets_udp == null) _throwNotAvailable();

    var completer = ChromeCompleter<int>.oneArg();
    _sockets_udp.callMethod(
        'setMulticastLoopbackMode', [socketId, enabled, completer.callback]);
    return completer.future;
  }

  /// Sets the time-to-live of multicast packets sent to the multicast group.
  ///
  /// Calling this method does not require multicast permissions.
  ///
  /// [socketId]: The socket ID.
  /// [ttl]: The time-to-live value.
  /// [callback]: Called when the configuration operation completes.
  ///
  /// Returns:
  /// Callback from the `setMulticastTimeToLive` method.
  /// [result]: The result code returned from the underlying network call. A
  /// negative value indicates an error.
  Future<int> setMulticastTimeToLive(int socketId, int ttl) {
    if (_sockets_udp == null) _throwNotAvailable();

    var completer = ChromeCompleter<int>.oneArg();
    _sockets_udp.callMethod(
        'setMulticastTimeToLive', [socketId, ttl, completer.callback]);
    return completer.future;
  }

  /// Pauses or unpauses a socket. A paused socket is blocked from firing
  /// `onReceive` events.
  /// [connectionId]: The socket ID.
  /// [paused]: Flag to indicate whether to pause or unpause.
  /// [callback]: Called when the socket has been successfully paused or
  /// unpaused.
  Future setPaused(int socketId, bool paused) {
    if (_sockets_udp == null) _throwNotAvailable();

    var completer = ChromeCompleter.noArgs();
    _sockets_udp
        .callMethod('setPaused', [socketId, paused, completer.callback]);
    return completer.future;
  }

  /// Updates the socket properties.
  /// [socketId]: The socket ID.
  /// [properties]: The properties to update.
  /// [callback]: Called when the properties are updated.
  Future update(int socketId, SocketProperties properties) {
    if (_sockets_udp == null) _throwNotAvailable();

    var completer = ChromeCompleter.noArgs();
    _sockets_udp.callMethod(
        'update', [socketId, jsify(properties), completer.callback]);
    return completer.future;
  }

  void _throwNotAvailable() {
    throw UnsupportedError("'chrome.sockets.udp' is not available");
  }
}

/// Result of `create` call.
class CreateInfo extends ChromeObject {
  CreateInfo({int socketId}) {
    if (socketId != null) this.socketId = socketId;
  }

  CreateInfo.fromProxy(JsObject jsProxy) : super.fromProxy(jsProxy);

  int get socketId => jsProxy['socketId'];

  set socketId(int value) => jsProxy['socketId'] = value;
}

/// Data from an `onReceiveError` event.
class ReceiveErrorInfo extends ChromeObject {
  ReceiveErrorInfo({int socketId, int resultCode}) {
    if (socketId != null) this.socketId = socketId;
    if (resultCode != null) this.resultCode = resultCode;
  }

  ReceiveErrorInfo.fromProxy(JsObject jsProxy) : super.fromProxy(jsProxy);

  int get resultCode => jsProxy['resultCode'];

  set resultCode(int value) => jsProxy['resultCode'] = value;

  int get socketId => jsProxy['socketId'];

  set socketId(int value) => jsProxy['socketId'] = value;
}

/// Data from an `onReceive` event.
class ReceiveInfo extends ChromeObject {
  ReceiveInfo({int socketId, ArrayBuffer data}) {
    if (socketId != null) this.socketId = socketId;
    if (data != null) this.data = data;
  }

  ReceiveInfo.fromProxy(JsObject jsProxy) : super.fromProxy(jsProxy);

  ArrayBuffer get data => _createArrayBuffer(jsProxy['data']);

  set data(ArrayBuffer value) => jsProxy['data'] = jsify(value);

  int get socketId => jsProxy['socketId'];

  set socketId(int value) => jsProxy['socketId'] = value;
}

class SecureOptions extends ChromeObject {
  SecureOptions({TLSVersionConstraints tlsVersion}) {
    if (tlsVersion != null) this.tlsVersion = tlsVersion;
  }

  SecureOptions.fromProxy(JsObject jsProxy) : super.fromProxy(jsProxy);

  TLSVersionConstraints get tlsVersion =>
      _createTLSVersionConstraints(jsProxy['tlsVersion']);

  set tlsVersion(TLSVersionConstraints value) =>
      jsProxy['tlsVersion'] = jsify(value);
}

/// Result of the `send` method.
class SendInfo extends ChromeObject {
  SendInfo({int resultCode, int bytesSent}) {
    if (resultCode != null) this.resultCode = resultCode;
    if (bytesSent != null) this.bytesSent = bytesSent;
  }

  SendInfo.fromProxy(JsObject jsProxy) : super.fromProxy(jsProxy);

  int get bytesSent => jsProxy['bytesSent'];

  set bytesSent(int value) => jsProxy['bytesSent'] = value;

  int get resultCode => jsProxy['resultCode'];

  set resultCode(int value) => jsProxy['resultCode'] = value;
}

/// Result of the `getInfo` method.
class SocketInfo extends ChromeObject {
  SocketInfo(
      {int socketId,
      bool persistent,
      String name,
      int bufferSize,
      bool paused,
      bool connected,
      String localAddress,
      int localPort,
      String peerAddress,
      int peerPort}) {
    if (socketId != null) this.socketId = socketId;
    if (persistent != null) this.persistent = persistent;
    if (name != null) this.name = name;
    if (bufferSize != null) this.bufferSize = bufferSize;
    if (paused != null) this.paused = paused;
    if (connected != null) this.connected = connected;
    if (localAddress != null) this.localAddress = localAddress;
    if (localPort != null) this.localPort = localPort;
    if (peerAddress != null) this.peerAddress = peerAddress;
    if (peerPort != null) this.peerPort = peerPort;
  }

  SocketInfo.fromProxy(JsObject jsProxy) : super.fromProxy(jsProxy);

  int get bufferSize => jsProxy['bufferSize'];

  set bufferSize(int value) => jsProxy['bufferSize'] = value;

  bool get connected => jsProxy['connected'];

  set connected(bool value) => jsProxy['connected'] = value;

  String get localAddress => jsProxy['localAddress'];

  set localAddress(String value) => jsProxy['localAddress'] = value;

  int get localPort => jsProxy['localPort'];

  set localPort(int value) => jsProxy['localPort'] = value;

  String get name => jsProxy['name'];

  set name(String value) => jsProxy['name'] = value;

  bool get paused => jsProxy['paused'];

  set paused(bool value) => jsProxy['paused'] = value;

  String get peerAddress => jsProxy['peerAddress'];

  set peerAddress(String value) => jsProxy['peerAddress'] = value;

  int get peerPort => jsProxy['peerPort'];

  set peerPort(int value) => jsProxy['peerPort'] = value;

  bool get persistent => jsProxy['persistent'];

  set persistent(bool value) => jsProxy['persistent'] = value;

  int get socketId => jsProxy['socketId'];

  set socketId(int value) => jsProxy['socketId'] = value;
}

/// The socket properties specified in the `create` or `update` function. Each
/// property is optional. If a property value is not specified, a default value
/// is used when calling `create`, or the existing value if preserved when
/// calling `update`.
class SocketProperties extends ChromeObject {
  SocketProperties({bool persistent, String name, int bufferSize}) {
    if (persistent != null) this.persistent = persistent;
    if (name != null) this.name = name;
    if (bufferSize != null) this.bufferSize = bufferSize;
  }

  SocketProperties.fromProxy(JsObject jsProxy) : super.fromProxy(jsProxy);

  int get bufferSize => jsProxy['bufferSize'];

  set bufferSize(int value) => jsProxy['bufferSize'] = value;

  String get name => jsProxy['name'];

  set name(String value) => jsProxy['name'] = value;

  bool get persistent => jsProxy['persistent'];

  set persistent(bool value) => jsProxy['persistent'] = value;
}

class TLSVersionConstraints extends ChromeObject {
  TLSVersionConstraints({String min, String max}) {
    if (min != null) this.min = min;
    if (max != null) this.max = max;
  }

  TLSVersionConstraints.fromProxy(JsObject jsProxy) : super.fromProxy(jsProxy);

  String get max => jsProxy['max'];

  set max(String value) => jsProxy['max'] = value;

  String get min => jsProxy['min'];

  set min(String value) => jsProxy['min'] = value;
}
