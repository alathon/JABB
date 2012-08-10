TARGET=$(notdir $(basename $(CURDIR)))

all:
	DreamMaker $(TARGET).dme
	mv ${TARGET}.dmb bin

depend:
	DreamDownload Alathon.Alaparser
	DreamDownload Alathon.InputGrabber
	DreamDownload Keeth.kText
	DreamDownload Theodis.QuickSort
	DreamDownload Stephen001.EventScheduling

clean:
	rm -rf $(TARGET).zip
	rm -rf bin/$(TARGET).dmb
	rm -rf $(TARGET).rsc

zip:
	rm -rf $(TARGET).zip
	zip -R $(TARGET).zip *.dm *.dme
