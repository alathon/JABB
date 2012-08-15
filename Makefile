include vars.sh

LOGDATE=$(shell date +'%d%m%y')

all: compile

compile:
	DreamMaker $(TARGET).dme
	mv ${TARGET}.dmb ${DMB}

stop:
	kill -9 `pgrep -f "DreamDaemon ${DMB}"`

run:
	DreamDaemon $(DMB) $(PORT) -trusted -log logs/$(LOGDATE).log &>./logs/out.log &

depend:
	DreamDownload Alathon.Alaparser &
	DreamDownload Alathon.InputGrabber &
	DreamDownload Keeth.kText &
	DreamDownload Theodis.QuickSort &
	DreamDownload Stephen001.EventScheduling &

clean:
	rm -f $(TARGET).zip
	rm -f $(DMB)
	rm -f $(TARGET).rsc

zip:
	rm -f $(TARGET).zip
	zip -R $(TARGET).zip *.dm *.dme
