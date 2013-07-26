#!/usr/bin/python

# Spotify-notify
#
# v0.6d (28th aug 11)
# by JonW (jon.neverwinter@gmail.com)
# patched 20110907 by Jansen Price (sumpygump@gmail.com)
# patched 20120729 by Jansen Price (sumpygump@gmail.com) and brandl.matthaeus
#
# Original by SveinT (sveint@gmail.com)
# up to v0.5.2 (27th jan 11)


import dbus

bus = dbus.Bus(dbus.Bus.TYPE_SESSION)

spotifyservice = bus.get_object('com.spotify.qt', '/')
cmd = spotifyservice.get_dbus_method(
		'GetMetadata',
		'org.freedesktop.MediaPlayer2'
	)
track = cmd()

trackInfo = {}
trackMap  = {
		'artist'    : 'xesam:artist',
		'album'     : 'xesam:album',
		'title'     : 'xesam:title',
		'year'      : 'xesam:contentCreated',
		}

# Fetch the track information for the notification window.
for key in trackMap:
	if not trackMap[key] in track:
		continue
	piece = track[trackMap[key]]
	if key == 'year':
		piece = str(piece[:4])
	elif isinstance(piece, list):
		piece = ", ".join(piece)

	if not isinstance(piece, str):
		piece = str(piece)

	trackInfo[key] = piece.encode('utf-8')

# Send track change information to stdout
print "{0} | {1} | {2} ({3})".format(
		trackInfo['artist'],
		trackInfo['title'],
		trackInfo['album'],
		trackInfo['year']
		)
