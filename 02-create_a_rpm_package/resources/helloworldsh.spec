Name:               helloworldsh
Version:            1 
Release:            1%{?dist}
Summary:            A script which says 'Hello World'
Group:              Misc 
License:            GPL 
Source0:            helloworldsh-1.tgz 
BuildRoot:          %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArchitectures: noarch
Requires:           bash  

%description
This package was made for the purpose a training lab.

%prep
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT

%setup -q


%build
cp -ra * $RPM_BUILD_ROOT

#configure

%install

%clean
rm -rf $RPM_BUILD_ROOT

%changelog
* Mon Apr  4 2011 Louis Coilliot 
- creation

%files
%defattr(-,root,root,-)
%attr(0755,root,root) /usr/bin/helloworld.sh


