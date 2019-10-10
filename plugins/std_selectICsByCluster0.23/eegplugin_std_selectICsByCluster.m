% eegplugin_std_selectICsByCluster() - This is a plugin for selectICsByClusterecting cluster ICs
%                            in the STUDY to scalp channels.

% Author: Makoto Miyakoshi, JSPS/SCCN,INC,UCSD
% History
% 05/22/2015 ver 1.4 by Makoto. Renamed ('backprojection' is wrong, it's a forward projection)
% 01/08/2015 ver 1.3 by Makoto. Major update.
% 06/28/2013 ver 1.2 by Makoto. submenu = uimenu( std, 'label', 'Backproj from clst to chan', 'userdata', 'startup:off;study:on');
% 01/10/2013 ver 1.1 by Makoto. Minor changes.
% 10/26/2012 ver 1.0 by Makoto. Created.

% Copyright (C) 2012, Makoto Miyakoshi JSPS/SCCN,INC,UCSD
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

function eegplugin_std_selectICsByCluster( fig, try_strings, catch_strings);

 vers = '0.23';
    if nargin < 3
        error('eegplugin_std_selectICsByCluster requires 3 arguments');
    end
    
% create menu
std = findobj(fig, 'tag', 'study');
submenu = uimenu( std, 'label', 'Select ICs by Cluster', 'userdata', 'startup:off;study:on');

% add new submenu
uimenu( submenu, 'label', 'Select ICs By Cluster', 'callback', 'std_pop_selectICsByCluster', 'userdata', 'startup:off;study:on');
uimenu( submenu, 'label', 'Plot ERP & Env of selected ICs', 'callback', 'std_plot_selectICsByCluster','userdata', 'startup:off;study:on', 'separator','on');
