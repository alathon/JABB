include vars.sh

all: compile

compile:
	DreamMaker $(TARGET).dme
	mv $(TARGET).dmb bin/$(DMB)

stop:
	kill -9 `pgrep -f "DreamDaemon bin ${DMB}"`

run:
	DreamDaemon bin/$(DMB) $(PORT) -log $(LOG) &

depend:
	DreamDownload Alathon.Alaparser &
	DreamDownload Alathon.InputGrabber &
	DreamDownload Keeth.kText &
	DreamDownload Theodis.QuickSort &
	DreamDownload Stephen001.EventScheduling &

clean:
	rm -f $(TARGET).zip
	rm -f bin/$(DMB)
	rm -f $(TARGET).rsc

zip:
	rm -f $(TARGET).zip
	zip -R $(TARGET).zip *.dm *.dme
