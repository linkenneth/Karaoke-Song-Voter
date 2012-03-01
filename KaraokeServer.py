from bottle import get, post, request
from bottle import redirect
from bottle import run, template

from youtube import get_video_results
import moderator

sessions = {}

"""
Home page handler
"""
@get('/')
def home_handler():
    output = template('home2')
    return output

"""
Session creation handler
"""
@post('/create')
def create_handler():
    global sessions
    session = request.forms.sessionName
    if session not in sessions:
        sessions[session] = {}
    redirect('/vote/%s' % session)

"""
Player page handler
"""
@get('/play/<session>')
def player_handler(session=''):
    if session in sessions:
        content = {'session': session}
        response = template('player2', content=content)
        return response
    else:
        redirect('/')

"""
Top video handler
"""
@get('/play/<session>/top')
def top_handler(session=''):
    if session in sessions:
        videos = get_sorted_videos(sessions[session])
        if videos:
            return {'top': videos[0]}
    return {'top': ''}

"""
Next video handler
"""
@post('/play/<session>/next')
def next_handler(session=''):
    if session in sessions:
        videos = get_sorted_videos(sessions[session])
        if videos:
            vid = videos[0]
            del sessions[session][vid['id']]
            return {'next': vid}
    return {'next': ''}

"""
Session page handler
"""
@get('/vote/<session>')
def session_handler(session=''):
    if session in sessions:
        content = {'session': session,
                   'videos': []
                   }
        if request.query.query:
            videos = get_video_results(request.query.query)
            for vid in videos:
                url = vid['vid_url']
                url = url.split('?v=')[1]
                url = url.split('&')[0]
                vid['vid_url'] = url
            content['videos'] = videos
            response = template('Search4', content=content)
        else:
            content['videos'] = get_sorted_videos(sessions[session])
            response = template('Vote', content=content)
        return response
    else:
        redirect('/')

"""
Search page handler
"""
#@get('/vote/<session>/search')
def search_handler(session=''):
    if session in sessions:
        content = {
            'session': session,
            'videos': []
            }
        if request.query.query:
            videos = get_video_results(request.query.query)
            print videos
            for vid in videos:
                url = vid['vid_url']
                print url
                url = url.split('?v=')[1]
                url = url.split('&')[0]
                vid['vid_url'] = url
                print url
            content['videos'] = videos

        response = template('Search3', content=content)
        return response
    else:
        redirect('/')

"""
Add submission handler
"""
@post('/vote/<session>/add')
def add_handler(session=''):
    if session in sessions:
        videos = sessions[session]
        new_id = max(videos.keys() + [-1]) + 1
        videos[new_id] = dict(request.forms)
        videos[new_id]['score'] = 0
        videos[new_id]['id'] = new_id
        redirect('/vote/%s' % session)
    else:
        redirect('/')

"""
Submission voting handler
"""
@post('/vote/<session>/<video:int>/<v:re:\+|\->')
def vote_handler(session='', video=-1, v=''):
    if session in sessions:
        change = 0
        if v == '+':
            change = 1
        elif v == '-':
            change = -1
        sessions[session][video]['score'] += change
        redirect('/vote/%s' % session)
    else:
        redirect('/')

@get('/test/<session>')
def testy(session=''):
    global a
    a += 1
    return {'a': a}

def get_sorted_videos(videos):
    return sorted(videos.values(), key=lambda vid: -vid['score'])

run(host='localhost', port=8080)
#run(host='136.152.38.228', port=80)
