/**********************************************************************
* This file is part of Ompiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
* Contributors:                                                       *
* - Trek Global Corporation                                           *
* - Heng Sin Low                                                      *
**********************************************************************/
package org.idempiere.server.cluster.callable;

import java.io.Serializable;
import java.util.concurrent.Callable;

import org.compiere.server.AdempiereServerMgr;
import org.compiere.server.IServerManager;
import org.compiere.server.ServerInstance;

/**
 * @author hengsin
 *
 */
public class StopCallable implements Callable<Response>, Serializable {

	/**
	 * generated serial
	 */
	private static final long serialVersionUID = 3496041492358893501L;
	private String serverId;

	/**
	 * @param serverId
	 */
	public StopCallable(String serverId) {
		this.serverId = serverId;
	}

	@Override
	public Response call() throws Exception {
		Response response = new Response();
		IServerManager serverMgr = AdempiereServerMgr.get(false);
		if (serverMgr != null) {
			ServerInstance server = serverMgr.getServerInstance(serverId);
			if (server != null) {
				response.error = serverMgr.stop(serverId);
				response.serverId = server.getServerId();
			}
		}
		
		return response;
	}
}
