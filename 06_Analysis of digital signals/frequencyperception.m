function varargout = frequencyperception(varargin)
% FREQUENCYPERCEPTION M-file for frequencyperception.fig
%      FREQUENCYPERCEPTION, by itself, creates a new FREQUENCYPERCEPTION or raises the existing
%      singleton*.
%
%      H = FREQUENCYPERCEPTION returns the handle to a new FREQUENCYPERCEPTION or the handle to
%      the existing singleton*.
%
%      FREQUENCYPERCEPTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FREQUENCYPERCEPTION.M with the given input arguments.
%
%      FREQUENCYPERCEPTION('Property','Value',...) creates a new FREQUENCYPERCEPTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Frequenzwahrnehmung_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to frequencyperception_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help frequencyperception

% Last Modified by GUIDE v2.5 16-Oct-2018 15:15:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @frequencyperception_OpeningFcn, ...
                   'gui_OutputFcn',  @frequencyperception_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before frequencyperception is made visible.
function frequencyperception_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to frequencyperception (see VARARGIN)

% Choose default command line output for frequencyperception
handles.output = hObject;

% initialize data
fS = 44100;    % sampling frequency
%fS = 128000;    % sampling frequency
f100 = 100;     % freq. of 1st sin
f200 = 200;     % freq. of 1st sin
f400 = 400;     % freq. of 1st sin
f800 = 800;     % freq. of 1st sin
f1600 = 1600;     % freq. of 1st sin
f2000 = 2000;     % freq. of 1st sin
f3200 = 3200;     % freq. of 1st sin
f6400 = 6400;     % freq. of 1st sin
f12800 = 10000;     % freq. of 1st sin
a100 = .1;     % freq. of 1st sin
a200 = .1;     % freq. of 1st sin
a400 = .1;     % freq. of 1st sin
a800 = .1;     % freq. of 1st sin
a1600 = .1;     % freq. of 1st sin
a2000 = .0001;     % freq. of 1st sin
a3200 = .1;     % freq. of 1st sin
a6400 = .1;     % freq. of 1st sin
a12800 = .1;     % freq. of 1st sin
secs = 1;     % duration of signal
handles.fS = fS;
handles.f100 = f100;
handles.f200 = f200;
handles.f400 = f400;
handles.f800 = f800;
handles.f1600 = f1600;
handles.f2000 = f2000;  % reference frequency for 0 dB
handles.f3200 = f3200;
handles.f6400 = f6400;
handles.f12800 = f12800;
handles.a100 = a100;
handles.a200 = a200;
handles.a400 = a400;
handles.a800 = a800;
handles.a1600 = a1600;
handles.a2000 = a2000;
handles.a2000ref = a2000;   % set default ref value for 0 dB
handles.a3200 = a3200;
handles.a6400 = a6400;
handles.a12800 = a12800;
handles.a100 = a100;
handles.secs = secs;
handles.fig = 1;  % handler to figure
% Update handles structure
s2000 = cossig1(secs, .0001, 2000, fS);  % 50 Hz Signal 
handles.s2000 = s2000;
guidata(hObject, handles);

% UIWAIT makes frequencyperception wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = frequencyperception_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a = get(hObject,'Value');
s = cossig1(handles.secs, a, handles.f100, handles.fS); 
handles.s100 = s;
handles.a100 = a;
guidata(hObject, handles);
sound([handles.s2000 handles.s100],handles.fS);
%sound(handles.s100,handles.fS);
% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',0.0001);


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a = get(hObject,'Value');
s = cossig1(handles.secs, a, handles.f200, handles.fS); 
handles.s200 = s;
handles.a200 = a;
guidata(hObject, handles);
sound([handles.s2000 handles.s200],handles.fS);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',0.0001);


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a = get(hObject,'Value');
s = cossig1(handles.secs, a, handles.f400, handles.fS); 
handles.s400 = s;
handles.a400 = a;
guidata(hObject, handles);
sound([handles.s2000 handles.s400],handles.fS);

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',0.0001);


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a = get(hObject,'Value');
s = cossig1(handles.secs, a, handles.f800, handles.fS); 
handles.s800 = s;
handles.a800 = a;
guidata(hObject, handles);
sound([handles.s2000 handles.s800],handles.fS);


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',0.0001);


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a = get(hObject,'Value');
s = cossig1(handles.secs, a, handles.f1600, handles.fS); 
handles.s1600 = s;
handles.a1600 = a;
guidata(hObject, handles);
sound([handles.s2000 handles.s1600],handles.fS);



% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',0.0001);


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a = get(hObject,'Value');
s = cossig1(handles.secs, a, handles.f3200, handles.fS); 
handles.s3200 = s;
handles.a3200 = a;
guidata(hObject, handles);
sound([handles.s2000 handles.s3200],handles.fS);


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',0.0001);


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a = get(hObject,'Value');
s = cossig1(handles.secs, a, handles.f6400, handles.fS); 
handles.s6400 = s;
handles.a6400 = a;
%plot(s(1:100));
guidata(hObject, handles);
sound([handles.s2000 handles.s6400],handles.fS);


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',0.0001);


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a = get(hObject,'Value');
s = cossig1(handles.secs, a, handles.f12800, handles.fS); 
%plot(s(1:10000));
handles.s12800 = s;
handles.a12800 = a;
guidata(hObject, handles);
s2= [handles.s2000 handles.s12800];
%plot(s2(10000:20000));
sound([handles.s2000 handles.s12800],handles.fS);


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',0.0001);




% --- Executes on slider movement.
function reference_Callback(hObject, eventdata, handles)
% hObject    handle to reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%
% reference signal at 2000 Hz
a = get(hObject,'Value')
s = cossig1(handles.secs, a, handles.f2000, handles.fS); 
handles.s2000 = s;
handles.a2000 = a;
guidata(hObject, handles);
sound(handles.s2000,handles.fS);


% --- Executes during object creation, after setting all properties.
function reference_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',0.0001);




% --- Executes on button press in plot.
function plot_Callback(hObject, eventdata, handles)
% hObject    handle to plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = [100 200 400 800 1600 2000 3200 6400 12800];
a = [handles.a100 handles.a200 handles.a400 handles.a800 handles.a1600 handles.a2000 handles.a3200 handles.a6400 handles.a12800]
a = 20*log10(a./handles.a2000ref);
semilogx(x,a);
grid on;
ylabel('Amplitude in dB');
xlabel('Frequency in Hz');
title('Frequency Perception');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% set refence at 2000 Hz

s = cossig1(handles.secs, handles.a2000, handles.f2000, handles.fS); 
handles.s2000ref = s;
handles.a2000ref = handles.a2000;
guidata(hObject, handles);
sound(handles.s2000ref,handles.fS);



% --- Executes on button press in hold.
function hold_Callback(hObject, eventdata, handles)
% hObject    handle to hold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure(handles.fig);
x = [100 200 400 800 1600 2000 3200 6400 10000];
a = [handles.a100 handles.a200 handles.a400 handles.a800 handles.a1600 handles.a2000 handles.a3200 handles.a6400 handles.a12800]
a = 20*log10(a./handles.a2000ref);
semilogx(x,a);
ylabel('Amplitude in dB');
xlabel('Frequency in Hz');
title('Frequency Perception');
grid on;
hold on;
guidata(hObject, handles);
