function varargout = signalandspectrum(varargin)
% SIGNALANDSPECTRUM M-file for signalandspectrum.fig
%
%     (c) InIT/ZHAW 2018
%
%      SIGNALANDSPECTRUM, by itself, creates a new SIGNALANDSPECTRUM or raises the existing
%      singleton*.
%
%      H = SIGNALANDSPECTRUM returns the handle to a new SIGNALANDSPECTRUM or the handle to
%      the existing singleton*.
%
%      SIGNALANDSPECTRUM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIGNALANDSPECTRUM.M with the given input arguments.
%
%      SIGNALANDSPECTRUM('Property','Value',...) creates a new SIGNALANDSPECTRUM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before signalundspektrum_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to signalandspectrum_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help signalandspectrum

% Last Modified by GUIDE v2.5 08-Sep-2022 17:11:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @signalandspectrum_OpeningFcn, ...
                   'gui_OutputFcn',  @signalandspectrum_OutputFcn, ...
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


% --- Executes just before signalandspectrum is made visible.
function signalandspectrum_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to signalandspectrum (see VARARGIN)

% Choose default command line output for signalandspectrum

handles.output = hObject;
handles.fS = 8000;
if audiodevinfo(1) > 0   % do we have a microphone?
    handles.r = audiorecorder(handles.fS, 16, 1);
end
%handles.r = audiorecorder(44100, 16, 1);
handles.f0 = 400;
handles.f1 = 800;
handles.f2 = 1200;
handles.f3 = 1600;
handles.f4 = 2000;
handles.a0 = 0.5;
handles.a1 = 0.5;
handles.a2 = 0.5;
handles.a3 = 0.5;
handles.a4 = 0.5;
handles.n = 0.5;
handles.min = 10;
handles.max = 2000;
handles.nfft = 256;
handles.winstart = 1;
handles.winend = handles.nfft;
handles.f = (0:handles.nfft-1)/handles.nfft*handles.fS;
handles.indB = false;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes signalandspectrum wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = signalandspectrum_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
record(handles.r);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over start.
function start_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stop(handles.r);
s = double(getaudiodata(handles.r, 'int16'));
handles.s = s./max(s);
set(handles.slider9,'Value',get(handles.slider9,'Min'));
handles.winstart = 1;
handles.winend = handles.nfft;
guidata(hObject, handles);
plotaxes(handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
size(handles.s)
sound(handles.s,handles.fS);



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2);
specgramdemo(handles.s,handles.fS, handles.nfft);



% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'maximum') to determine range of slider
handles.a0 = get(hObject,'Value');
diff = get(hObject,'Max') - get(hObject,'Min');
handles.a0 = (get(hObject,'Value')-get(hObject,'Min'))/diff;  % normalized value 0..1
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'maximum') to determine range of slider
handles.a1 = get(hObject,'Value');
diff = get(hObject,'Max') - get(hObject,'Min');
handles.a1 = (get(hObject,'Value')-get(hObject,'Min'))/diff;  % normalized value 0..1
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'maximum') to determine range of slider
handles.a2 = get(hObject,'Value');
diff = get(hObject,'Max') - get(hObject,'Min');
handles.a2 = (get(hObject,'Value')-get(hObject,'Min'))/diff;  % normalized value 0..1
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'maximum') to determine range of slider
handles.a3 = get(hObject,'Value');
diff = get(hObject,'Max') - get(hObject,'Min');
handles.a3 = (get(hObject,'Value')-get(hObject,'Min'))/diff;  % normalized value 0..1
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'maximum') to determine range of slider
handles.a4 = get(hObject,'Value');
diff = get(hObject,'Max') - get(hObject,'Min');
handles.a4 = (get(hObject,'Value')-get(hObject,'Min'))/diff;  % normalized value 0..1
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on button press in generate.
function generate_Callback(hObject, eventdata, handles)
% hObject    handle to generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t = 1:handles.fS;
handles.s = handles.a0*cos(2*pi*handles.f0/handles.fS*t) + handles.a1*cos(2*pi*handles.f1/handles.fS*t) + handles.a2*cos(2*pi*handles.f2/handles.fS*t) + handles.a3*cos(2*pi*handles.f3/handles.fS*t) + handles.a4*cos(2*pi*handles.f4/handles.fS*t);
n = rand(1,handles.fS)-0.5; % symmetric to 0
handles.ns = handles.n*n;
handles.s = handles.s + handles.ns;
set(handles.slider9,'Value',get(handles.slider9,'Min'));
handles.winstart = 1;
handles.winend = handles.nfft;
guidata(hObject, handles);
plotaxes(handles);

function plotaxes(handles)
% plot the two axes in dB or lin
if handles.indB == true
    plotaxesdB(handles);
else
    plotaxesLin(handles);
end

function plotaxesLin(handles)
% plot the two axes
axes(handles.axes1);
str = [strcat('Sampling Rate: ', num2str(handles.fS),'Hz , Window Size: ',num2str(handles.nfft))];
t = (handles.winstart:handles.winend);
plot(t,handles.s(handles.winstart:handles.winend),'-o');
title(str);
axis tight;
ylabel('Amplitude');
xlabel('Sample');
axes(handles.axes2);
%tmp = 20*log10(abs(fft(handles.s(1:handles.nfft))));
%spec = tmp-maximum(tmp);
spec = abs(fft(handles.s(handles.winstart:handles.winend)))/handles.nfft;
%spec = tmp/max(tmp);
mstem(handles.f,spec,'-o');
title('DFT-Spectrum of above signal window');
axis tight;
ylabel('Amplitude');
xlabel('Hz');

function plotaxesdB(handles)
% plot the two axes
axes(handles.axes1);
str = [strcat('Sampling Rate: ', num2str(handles.fS),'Hz , Window Size: ',num2str(handles.nfft))];
t = (handles.winstart:handles.winend);
plot(t,handles.s(handles.winstart:handles.winend));
title(str);
axis tight;
ylabel('Amplitude');
xlabel('Sample');
axes(handles.axes2);
tmp = 20*log10(abs(fft(handles.s(handles.winstart:handles.winend))));
spec = tmp-max(tmp);
%tmp = abs(fft(handles.s(handles.winstart:handles.winend)));
%spec = tmp/max(tmp);
plot(handles.f,spec,'-o');
title('DFT-Spectrum of above signal window');
axis tight;
ylabel('Amplitude in dB');
xlabel('Hz');



% --- Executes on button press in gensweep.
function gensweep_Callback(hObject, eventdata, handles)
% hObject    handle to gensweep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = gensweep(handles.min, handles.max, handles.fS, 1);
handles.s = s./2;
set(handles.slider9,'Value',get(handles.slider9,'Min'));
handles.winstart = 1;
handles.winend = handles.nfft;
guidata(hObject, handles);
plotaxes(handles);

% --- Executes on slider movement.
function minimum_Callback(hObject, eventdata, handles)
% hObject    handle to minimum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'maximum') to determine range of slider
handles.min = get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function minimum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minimum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%set(hObject,'Value',10);

% --- Executes on slider movement.
function maximum_Callback(hObject, eventdata, handles)
% hObject    handle to maximum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'maximum') to determine range of slider
handles.max = get(hObject,'Value');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function maximum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maximum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%set(hObject,'Value',200.0);




% --- Executes on button press in whitenoise.
function whitenoise_Callback(hObject, eventdata, handles)
% hObject    handle to whitenoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = rand(handles.fS,1)-0.5; % symmetric to 0
handles.s = s/2;
set(handles.slider9,'Value',get(handles.slider9,'Min'));
handles.winstart = 1;
handles.winend = handles.nfft;
guidata(hObject, handles);
plotaxes(handles);

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1



% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2



% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
axes(handles.axes1);
handles.slider9 = hObject;
slider9_min = get(hObject,'Min');
slider9_max = get(hObject,'Max');
slider9_val = get(hObject,'Value');
position = min(slider9_val*length(handles.s), length(handles.s)-handles.nfft);
handles.winstart = round(position+1);
handles.winend = round(position+handles.nfft);
guidata(hObject, handles);
plotaxes(handles);


% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Impulse.
function Impulse_Callback(hObject, eventdata, handles)
% hObject    handle to Impulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = zeros(1,handles.fS);
s(round(handles.nfft/2)) = 1;
handles.s = s;
set(handles.slider9,'Value',get(handles.slider9,'Min'));
handles.winstart = 1;
handles.winend = handles.nfft;
guidata(hObject, handles);
plotaxes(handles);

% --- Executes on button press in Rectangle.
function Rectangle_Callback(hObject, eventdata, handles)
% hObject    handle to Rectangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = zeros(1,handles.fS);
s(50:150) = 1;
handles.s = s;
set(handles.slider9,'Value',get(handles.slider9,'Min'));
handles.winstart = 1;
handles.winend = handles.nfft;
guidata(hObject, handles);
plotaxes(handles);




% --- Executes on button press in ImpulseTrain.
function ImpulseTrain_Callback(hObject, eventdata, handles)
% hObject    handle to ImpulseTrain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s = zeros(1,handles.fS);
idx = 8*[1:round(handles.fS/8)];
s(idx) = 1;
handles.s = s;
set(handles.slider9,'Value',get(handles.slider9,'Min'));
handles.winstart = 1;
handles.winend = handles.nfft;
guidata(hObject, handles);
plotaxes(handles);


% --- Executes on slider movement.
function slider11_Callback(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'maximum') to determine range of slider
handles.n = get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of checkbox1
handles.indB = get(hObject,'Value');
guidata(hObject, handles);
plotaxes(handles);


% --- Executes during object creation, after setting all properties.
function start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if audiodevinfo(1) < 1
    set(hObject,'Visible','Off');
else
   set(hObject,'Visible','On'); 
end


% --- Executes during object creation, after setting all properties.
function stop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if audiodevinfo(1) < 1
    set(hObject,'Visible','Off');
else
   set(hObject,'Visible','On'); 
end


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
