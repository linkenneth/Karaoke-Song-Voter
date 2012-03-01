
import gdata.youtube
import gdata.youtube.service

def get_video_results(query, maxReturn = 10):
    startIndex = 1
    uri = 'https://gdata.youtube.com/feeds/api/videos?q={0}&orderby=relevance&start-index={1}&max-results={2}&v=2'.format(query, startIndex, maxReturn)
    videoInfo = [] 
    yt_service = gdata.youtube.service.YouTubeService()
    feed = yt_service.GetYouTubeVideoFeed(uri) 
    for entry in feed.entry:
        videoInfo.append({'vid_url': entry.media.player.url, 'thumbnail_url': entry.media.thumbnail[0].url, "title": entry.media.title.text, "vid_time": convertToMinutesAndSeconds(entry.media.duration.seconds)})
    return videoInfo

def convertToMinutesAndSeconds(timeString):
    minutes = int(timeString)/60
    seconds = int(timeString) % 60
    if seconds < 10:
        separator = ":0"
    else:
        separator = ":"
    return str(minutes) + separator + str(seconds)
